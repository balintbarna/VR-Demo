extends Reference
class_name OculusMobileConfig

func config(viewport: Viewport) -> bool:
    var interface = ARVRServer.find_interface("OVRMobile")
    if interface and interface.initialize():
        var ovr_init_config = preload("res://addons/godot_ovrmobile/OvrInitConfig.gdns").new()
        var ovr_performance = preload("res://addons/godot_ovrmobile/OvrPerformance.gdns").new()
        var ovr_display = preload("res://addons/godot_ovrmobile/OvrDisplay.gdns").new()
        var ovr_types = preload("res://addons/godot_ovrmobile/OvrVrApiTypes.gd").new()
        ovr_init_config.set_render_target_size_multiplier(1)
        ovr_performance.set_extra_latency_mode(ovr_types.OvrExtraLatencyMode.VRAPI_EXTRA_LATENCY_MODE_DYNAMIC)
        ovr_performance.set_foveation_level(3)
        ovr_performance.set_enable_dynamic_foveation(true)
        ovr_performance.set_clock_levels(3, 3)

        print("Color space:" + str(ovr_display.get_color_space()))

        var refresh_rates = ovr_display.get_supported_display_refresh_rates()
        print("Supported refresh rates:" + str(refresh_rates))

        var highest_rate = refresh_rates[len(refresh_rates) - 1]
        Engine.iterations_per_second = highest_rate
        Engine.target_fps = highest_rate
        print("Rates set to " + str(highest_rate))

        viewport.arvr = true
        OS.vsync_enabled = false
        Globals.mapping = OculusMobileInputMapping.new()
        return true
    return false