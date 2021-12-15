extends BaseMapping
class_name OculusMobileInputMapping


func _init():
    # BUTTONS --------------
    
    THUMB_POINTING_UP = 10
    INDEX_TOUCHING = 11
    INDEX_POINTING = 12
    
    # AXES --------------
    
    GRIP_STRENGTH = 3 # [-1; 1] = [idle; pressed]