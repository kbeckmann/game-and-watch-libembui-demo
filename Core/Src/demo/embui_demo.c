#include <assert.h>
#include <stdint.h>

#include "embui.h"
#include "main.h"
#include "gw_lcd.h"
#include "gw_buttons.h"

static uint32_t active_framebuffer = 0;
static uint32_t reload_in_progress;
extern LTDC_HandleTypeDef hltdc;

typedef struct eui_animation_node_ex {
    eui_animation_node_t node;
    float offset;
} eui_animation_node_ex_t;

void animation_apply_x(void *transformed_source, const eui_animation_node_t * const anim_node)
{
    eui_animation_node_ex_t *st = (eui_animation_node_ex_t *) anim_node;
    eui_rect_t *rect = (eui_rect_t *)transformed_source;

    float value = (*st->node.state);

    rect->pos.x += (value + st->offset) * (GW_LCD_WIDTH / 3 + 10);
    rect->pos.y += 0;
}

void add_box(eui_shape_t *shape_bg, eui_shape_t *shape_fg0, eui_shape_t *shape_fg1, eui_shape_t *shape_fg2, eui_animation_state_t *anim, uint32_t offset, eui_animation_node_ex_t *anim_fg)
{
    eui_color_t green = { .value = 0xff00ff00 };
    eui_color_t blue  = { .value = 0xffff0000 };

    EUI_INIT_SHAPE(*shape_fg0, 10, 10,    GW_LCD_WIDTH / 3,       (GW_LCD_HEIGHT * 3) / 4, green);
    EUI_INIT_SHAPE(*shape_fg1, 20, 10+10, GW_LCD_WIDTH / 3 - 20,                       30, blue);
    EUI_INIT_SHAPE(*shape_fg2, 20, 60,    GW_LCD_WIDTH / 3 - 20,                      120, blue);
    eui_node_add_last(&shape_bg->node, &shape_fg0->node);
    eui_node_add_last(&shape_bg->node, &shape_fg1->node);
    eui_node_add_last(&shape_bg->node, &shape_fg2->node);

    *anim_fg = (eui_animation_node_ex_t){
        .node = eui_create_animation_node(animation_apply_x, *anim),
        .offset = offset
    };

    shape_fg0->rect_animator = (eui_animation_node_t*)anim_fg;
    shape_fg1->rect_animator = (eui_animation_node_t*)anim_fg;
    shape_fg2->rect_animator = (eui_animation_node_t*)anim_fg;
}


void app_main(void)
{
    eui_err_t res;
    eui_renderer_t renderer = {
        .framebuffer = framebuffer1,
        .format = EUI_PIXEL_FORMAT_RGB_565,
        .size.width = GW_LCD_WIDTH,
        .size.height = GW_LCD_HEIGHT,
    };

    eui_shape_t shape_bg;
    eui_shape_t shape_fgx;

    eui_color_t red   = { .value = 0xff0000ff };
    eui_color_t green = { .value = 0xff00ff00 };
    eui_color_t blue  = { .value = 0xffff0000 };
    
    EUI_INIT_SHAPE(shape_bg,  0, 0, GW_LCD_WIDTH, GW_LCD_HEIGHT, red);

    res = eui_renderer_init(&renderer);
    assert(res == EUI_ERR_OK);
    res = eui_renderer_set_root(&renderer, &shape_bg.node);
    assert(res == EUI_ERR_OK);

    eui_context_t context = {
        .renderer = &renderer,
    };
    eui_init(&context);

    eui_animation_state_t anim_states[] = {
        eui_create_animation_state(500, 0, false, true),
    };
    anim_states[0].ease_cb = eui_easeinout;

    eui_set_animation_states(&context, anim_states, sizeof(anim_states)/sizeof(anim_states[0]));

    eui_shape_t shape_fg[30];
    eui_animation_node_ex_t anim_fg[10];
    for (int i = 0; i < 10; ++i) {
        add_box(&shape_bg, &shape_fg[i * 3], &shape_fg[i * 3 + 1], &shape_fg[i * 3 + 2], &anim_states[0], i + 1, &anim_fg[i]);
    }

    uint32_t t0 = HAL_GetTick();
    uint32_t t1;
    uint32_t frames = 0;
    float f = 1;
    while (1) {
        PROFILING_INIT(t_eui);
        PROFILING_START(t_eui);

        res = eui_run(&context);
        assert(res == EUI_ERR_OK);

        PROFILING_END(t_eui);

#ifdef PROFILING_ENABLED
        // printf("EUI: %d us\n", (1000000 * PROFILING_DIFF(t_eui)) / t_eui_t0.SecondFraction);
#endif

        static uint32_t last_buttons;
        uint32_t buttons = buttons_get();

        if (buttons && (buttons != last_buttons)) {
            switch (buttons) {
            case B_Left:
                if(!anim_states[0].running && anim_states[0].offset > -9){
                    anim_states[0].offset-=1;
                    anim_states[0].duration = -500;
                    anim_states[0].anim_value = 1;
                    anim_states[0].running = true;
                }
                break;
            case B_Right:
                if(!anim_states[0].running && anim_states[0].offset < 0){
                    anim_states[0].offset+=1;
                    anim_states[0].duration = 500;
                    anim_states[0].anim_value = 0;
                    anim_states[0].running = true;
                }
                break;

            default:
                break;
            }
        }

        t1 = HAL_GetTick();
        if (t1 - t0 >= 1000) {
            printf("FPS: %d: %d/%d\n", frames, frames, t1 - t0);
            frames = 0;
            t0 = t1;
        }

        frames++;

        uint16_t *dest = active_framebuffer ? framebuffer1 : framebuffer2;
        context.renderer->framebuffer = dest;

        active_framebuffer = active_framebuffer ? 0 : 1;
        while (reload_in_progress) {
            __WFI();
        }
        // HAL_Delay(20);
        reload_in_progress = true;
        HAL_LTDC_Reload(&hltdc, LTDC_RELOAD_VERTICAL_BLANKING);

    }
}


void HAL_LTDC_ReloadEventCallback (LTDC_HandleTypeDef *hltdc) {
    if (active_framebuffer == 0) {
        HAL_LTDC_SetAddress(hltdc, framebuffer2, 0);
    } else {
        HAL_LTDC_SetAddress(hltdc, framebuffer1, 0);
    }
    reload_in_progress = false;
}