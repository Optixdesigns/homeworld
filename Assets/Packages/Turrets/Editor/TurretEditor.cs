using UnityEngine;
using UnityEditor;
using System.Collections;

[CustomEditor(typeof(Turret))]
public class TurretEditor : Editor
{

    void OnSceneGUI ()
    {
        var t = target as Turret;
        Handles.color = Color.red;
        if (t.yaw != null)
        if (t.limitYaw) {
            Handles.DrawWireArc (t.yaw.position, t.yaw.up, t.yaw.forward, +t.yawRange, 2);
            Handles.DrawWireArc (t.yaw.position, t.yaw.up, t.yaw.forward, -t.yawRange, 2);
            var maxYawHandlePos = Quaternion.Euler (0, -t.yawRange, 0) * t.yaw.forward * 2;
            var minYawHandlePos = Quaternion.Euler (0, +t.yawRange, 0) * t.yaw.forward * 2;
            Handles.Label (t.yaw.position + minYawHandlePos, "Yaw Range");
            Handles.Label (t.yaw.position + maxYawHandlePos, "Yaw Range");
            t.yawRange = Handles.ScaleValueHandle (t.yawRange, t.yaw.position + maxYawHandlePos, Quaternion.LookRotation (t.yaw.right), 1, Handles.SphereCap, 1);
            t.yawRange = Handles.ScaleValueHandle (t.yawRange, t.yaw.position + minYawHandlePos, Quaternion.LookRotation (t.yaw.right), 1, Handles.SphereCap, 1);
        }
        Handles.color = Color.green;
        if (t.pitch != null) {
            var pitchMin = Quaternion.Euler (-t.pitchMin, 0, 0) * new Vector3 (0, 0, 2);
            var pitchMax = Quaternion.Euler (-t.pitchMax, 0, 0) * new Vector3 (0, 0, 2);
            var A = t.pitch.position + (t.yaw.rotation * pitchMax);
            var B = t.pitch.position + (t.yaw.rotation * pitchMin);
            Handles.Label (A, "Max Pitch");
            Handles.Label (B, "Min Pitch");
            Handles.DrawLine (A, t.pitch.position + t.yaw.rotation * (pitchMax * 10));
            Handles.DrawLine (B, t.pitch.position + t.yaw.rotation * (pitchMin * 10));
            t.pitchMax = Mathf.Repeat (Handles.ScaleValueHandle (t.pitchMax, A, Quaternion.LookRotation (t.pitch.up), 1, Handles.SphereCap, 0.1f), 360f);
            t.pitchMin = Mathf.Repeat (Handles.ScaleValueHandle (t.pitchMin, B, Quaternion.LookRotation (t.pitch.up), 1, Handles.SphereCap, 0.1f), 360f);
        }

        Handles.color = Color.yellow;
        foreach (var i in t.barrels) {
            var end = i.position - (i.forward * t.recoilLength);
            Handles.DrawLine (i.position, end);
            Handles.Label (end, "Recoil Length");
            t.recoilLength = Handles.ScaleValueHandle (t.recoilLength, end, i.rotation, 1, Handles.SphereCap, 0.1f);
        }
        if(GUI.changed) {
            EditorUtility.SetDirty(t);
        }
    }
}
