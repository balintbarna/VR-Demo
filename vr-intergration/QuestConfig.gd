extends Reference
class_name QuestConfig

func config(viewport: Viewport):
    var interface = ARVRServer.find_interface("OVRMobile")
    if interface and interface.initialize():
        var ovr_init_config = preload("res://addons/godot_ovrmobile/OvrInitConfig.gdns").new()
        var ovr_performance = preload("res://addons/godot_ovrmobile/OvrPerformance.gdns").new()
        var ovr_display = preload("res://addons/godot_ovrmobile/OvrDisplay.gdns").new()
        ovr_init_config.set_render_target_size_multiplier(1)
        ovr_performance.set_extra_latency_mode(1)
        viewport.arvr = true
        OS.vsync_enabled = false
        print("Color space:" + str(ovr_display.get_color_space()))
        var refresh_rates = ovr_display.get_supported_display_refresh_rates()
        print("Supported refresh rates:" + str(refresh_rates))
        var highest_rate = refresh_rates[len(refresh_rates) - 1]
        Engine.iterations_per_second = highest_rate
        Engine.target_fps = highest_rate
        print("Rates set to " + str(highest_rate))
        return true
    return false