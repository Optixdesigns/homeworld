import UnityEngine

/**
 * Class: MainCameraController
 * 
 * Extends: MonoBehaviour
 */
class MainCameraController(MonoBehaviour):
    public target as Transform
    public navPlane as Transform	# Plain used for navigation
    public distance = 10
    public minDistance = 3 // Minum distance to boject

    public mouseSens = 200    # Mouse sensitivity

    public yMinLimit = -20
    public yMaxLimit = 80

    private x = 0.0
    private y = 0.0

    private gameManager as GameObject

    def Awake():
        gameManager = GameObject.Find("GameManager")

    def Start():
        angles = transform.eulerAngles
        x = angles.y
        y = angles.x

        # Make the rigid body not change rotation
        if rigidbody:
            rigidbody.freezeRotation = true

    def LateUpdate():
        if target and Input.GetMouseButton(1):
            Rotate()

        if target: /// If we have a target, stay focused on it
            Focus()

        if Input.GetAxis("Mouse ScrollWheel") < 0:
            Zoom('back', mouseSens)
        elif Input.GetAxis("Mouse ScrollWheel") > 0:
            Zoom('forward', mouseSens)

        if Input.GetKeyDown(KeyCode.F) and gameManager.GetComponent(Select).gameObjects[0]:
            target = gameManager.GetComponent(Select).gameObjects[0].transform    /// First obj in selection
            Focus()

    /**
     * Function: Focus
     * 
     * Focus on object
     * 
     */
    def Focus():
        _updateTransform()

    /**
     * Function: Rotate
     * 
     * Rotate the camera
     * 
     * Returns:
     * 
     *   return description
     */
    def Rotate():
        x += Input.GetAxis("Mouse X") * mouseSens * 0.02
        y -= Input.GetAxis("Mouse Y") * mouseSens * 0.02

        _updateTransform()

    /**
     * Function: Zoom
     * 
     * Zooms the camera
     * 
     * Parameters:
     * 
     *   direction as string - direction
     *   speed as int        - speed
     * 
     * Returns:
     * 
     *   return description
     */
    def Zoom(direction as string, speed as int):
        if direction == 'back' and distance >= minDistance:
            distance = distance - speed * 0.02

        elif direction == 'forward':
            distance = distance + speed * 0.02

        _updateTransform()

    /**
     * Function: _clampAngle
     * 
     * Parameters:
     * 
     *   angle as int - angle
     *   min as int   - min
     *   max as int   - max
     * 
     * Returns:
     * 
     *   return angle
     */
    def _clampAngle(angle as int, min as int, max as int):
        if angle < -360:
            angle += 360
        if angle > 360:
            angle -= 360

        return Mathf.Clamp(angle, min, max)
    
    /**
     * Function: _updateTransform
     * 
     * Updates current transform, call this after altering camera values
     */
    def _updateTransform():
        y = _clampAngle(y, yMinLimit, yMaxLimit)

        rotation = Quaternion.Euler(y, x, 0)
        position = rotation * Vector3(0.0, 0.0, -distance) + target.position

        transform.rotation = rotation
        transform.position = position

