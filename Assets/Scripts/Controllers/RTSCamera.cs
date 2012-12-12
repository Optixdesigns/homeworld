using UnityEngine;
using System;

[AddComponentMenu("Camera Control/Smooth Follow")]
class RTSCamera : MonoBehaviour
{
    public float CameraMoveSpeed = 60;
    public float CameraMoveMouse = 40;
    public float CameraZoomSpeed = 30;
    public float CameraRotateSpeed = 30;
    public float Camera = 4;

    const float CameraMax = 50;
    const float CameraMin = 15;

    void LateUpdate()
    {
        if (hasInput())
        {
            float thiseulerX = transform.rotation.eulerAngles.x;
            transform.rotation = Quaternion.Euler(0, transform.eulerAngles.y, transform.eulerAngles.z);
            if (Input.GetAxis("Camera X") > 0)
            {
                transform.Translate(Vector3.forward * Time.deltaTime * CameraMoveSpeed);
            }
            if (Input.GetAxis("Camera X") < 0)
            {
                transform.Translate(Vector3.back * Time.deltaTime * CameraMoveSpeed);
            }
            if (Input.GetAxis("Camera Rotation") == 0)
            {
                if (Input.GetAxis("Camera Y") > 0)
                {
                    transform.Translate(Vector3.right * Time.deltaTime * CameraMoveSpeed);
                }
                if (Input.GetAxis("Camera Y") < 0)
                {
                    transform.Translate(Vector3.left * Time.deltaTime * CameraMoveSpeed);
                }
            }

            if (Input.GetAxis("Move Camera Enabler") != 0)
            {
                Screen.lockCursor = true;
                if (Input.GetAxis("Camera X Mouse") != 0)
                {
                    transform.Translate(Vector3.forward * Time.deltaTime * CameraMoveMouse * Input.GetAxis("Camera X Mouse"), Space.Self);
                }
                if (Input.GetAxis("Camera Y Mouse") != 0)
                {
                    transform.Translate(Vector3.right * Time.deltaTime * CameraMoveMouse * Input.GetAxis("Camera Y Mouse"), Space.Self);
                }
            }
            else if (Input.GetAxis("Camera Rotation") != 0)
            {
                Screen.lockCursor = true;
                if (Input.GetAxis("Camera X Mouse") != 0)
                {
                    transform.Rotate(Vector3.up * Time.deltaTime * CameraRotateSpeed * Input.GetAxis("Camera Y Mouse"), Space.World);
                }
            } 



            transform.rotation = Quaternion.Euler(thiseulerX, transform.eulerAngles.y, transform.eulerAngles.z);

            if (Input.GetAxis("Move Camera Enabler") == 0)
            {
                if (Input.GetAxis("Camera Rotation") == 0 && Input.GetAxis("Camera Zoom") != 0)
                {
                    transform.Translate(Vector3.forward * Time.deltaTime * CameraZoomSpeed * Input.GetAxis("Camera Zoom"), Space.Self);
                    while (transform.position.y > CameraMax)
                    {
                        transform.Translate(Vector3.forward * Time.deltaTime / 100, Space.Self);
                    }
                    while (transform.position.y < CameraMin)
                    {
                        transform.Translate(Vector3.back * Time.deltaTime / 100, Space.Self);
                    }
                }
            }
        }
        else
        {
            Screen.lockCursor = false;
        }
    }

    bool hasInput()
    {
        if (
                Input.GetAxis("Camera X") != 0 ||
                Input.GetAxis("Camera Y") != 0 ||
                Input.GetAxis("Move Camera Enabler") != 0 ||
                Input.GetAxis("Camera Zoom") != 0 ||
                Input.GetAxis("Camera Rotation") != 0
           )
        {
            return true;
        }
        return false;
    }
}