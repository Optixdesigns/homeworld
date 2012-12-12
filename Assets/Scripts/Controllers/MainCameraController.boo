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
    private z = 0.0

    private focusPosition as Vector3 = Vector3(0, 0, 0)     // Position to focus on

    public boundary as int = 20
    private screenWidth as int
    private screenHeight as int

    private gameManager as GameObject

    def Start():
        gameManager = GameObject.Find("GameManager")
        screenWidth = Screen.width
        screenHeight = Screen.height

        angles = transform.eulerAngles
        x = angles.y
        y = angles.x
        z = angles.x

        # Make the rigid body not change rotation
        if rigidbody:
            rigidbody.freezeRotation = true

    def LateUpdate():
        if target:
            focusPosition = target.position
        else:
            focusPosition = GetRaycast()

        BoundaryMovemement()

        if Input.GetMouseButton(1):
            Rotate()

        if target: /// If we have a target, stay focused on it
            Focus()

        if Input.GetAxis("Mouse ScrollWheel") < 0:
            Zoom('back', mouseSens)
        elif Input.GetAxis("Mouse ScrollWheel") > 0:
            Zoom('forward', mouseSens)

        // Focus on an object
        if Input.GetKeyDown(KeyCode.F) and gameManager.GetComponent(Select).gameObjects[0]:
            target = gameManager.GetComponent(Select).gameObjects[0].transform    /// First obj in selection
            Focus()

        

    def BoundaryMovemement():
        thiseulerX = transform.rotation.eulerAngles.x
        transform.rotation = Quaternion.Euler(0, transform.eulerAngles.y, transform.eulerAngles.z)
        
        if Input.mousePosition.x > screenWidth - boundary:
           transform.Translate(Vector3.right * Time.deltaTime * mouseSens * 0.2, Space.Self)
           LooseFocus()

        if Input.mousePosition.x < 0 + boundary:
           transform.Translate(Vector3.left * Time.deltaTime * mouseSens * 0.2, Space.Self)
           LooseFocus()

        if Input.mousePosition.y > screenHeight - boundary:
           transform.Translate(Vector3.forward * Time.deltaTime * mouseSens * 0.2, Space.Self)
           LooseFocus()

        if Input.mousePosition.y < 0 + boundary:
           transform.Translate(Vector3.back * Time.deltaTime * mouseSens * 0.2, Space.Self)
           LooseFocus()

        transform.rotation = Quaternion.Euler(thiseulerX, transform.eulerAngles.y, transform.eulerAngles.z)

    def GetRaycast():
        ray as Ray = camera.ViewportPointToRay(Vector3(0.5,0.5,0))
        hit as RaycastHit
        if Physics.Raycast(ray, hit):
            if hit.transform.name == "NavigationPlane":
                return hit.point
            #print ("I'm looking at " + hit.transform.name)

    /**
     * Function: Focus
     * 
     * Focus on object
     * 
     */
    def Focus():
        focusPosition = target.position
        _updateTransform()

    // Loose target focus
    def LooseFocus():
        target = null

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

        rotation = Quaternion.Euler(y, x, z)
        position = rotation * Vector3(0.0, 0.0, -distance) + focusPosition
        #position = rotation * Vector3(0.0, 0.0, -distance)

        transform.rotation = rotation
        transform.position = position

    def OnGUI(): 
        GUI.Box( Rect( (Screen.width / 2) - 140, 5, 280, 25 ), "Mouse Position = " + Input.mousePosition )
        GUI.Box( Rect( (Screen.width / 2) - 70, Screen.height - 30, 140, 25 ), "Mouse X = " + Input.mousePosition.x )
        GUI.Box( Rect( 5, (Screen.height / 2) - 12, 140, 25 ), "Mouse Y = " + Input.mousePosition.y )
