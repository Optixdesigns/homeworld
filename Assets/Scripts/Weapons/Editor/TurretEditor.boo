import UnityEngine
import UnityEditor
import System.Collections


[CustomEditor(typeof(Turret))]
public class TurretEditor(Editor):
	private def OnSceneGUI():
		t = (target as Turret)
		
		Handles.color = Color.red
		if t.yaw is not null:
			if t.limitYaw:
				Handles.DrawWireArc(t.yaw.position, t.yaw.up, t.yaw.forward, t.yawRange, 2)
				Handles.DrawWireArc(t.yaw.position, t.yaw.up, t.yaw.forward, -t.yawRange, 2)
				maxYawHandlePos = ((Quaternion.Euler(0, -t.yawRange, 0) * t.yaw.forward) * 2)
				minYawHandlePos = ((Quaternion.Euler(0, t.yawRange, 0) * t.yaw.forward) * 2)
				Handles.Label((t.yaw.position + minYawHandlePos), 'Yaw Range')
				Handles.Label((t.yaw.position + maxYawHandlePos), 'Yaw Range')
				t.yawRange = Handles.ScaleValueHandle(t.yawRange, (t.yaw.position + maxYawHandlePos), Quaternion.LookRotation(t.yaw.right), 1, Handles.SphereCap, 1)
				t.yawRange = Handles.ScaleValueHandle(t.yawRange, (t.yaw.position + minYawHandlePos), Quaternion.LookRotation(t.yaw.right), 1, Handles.SphereCap, 1)
		
		Handles.color = Color.green
		if t.pitch is not null:
			pitchMin = (Quaternion.Euler(-t.pitchMin, 0, 0) * Vector3(0, 0, 2))
			pitchMax = (Quaternion.Euler(-t.pitchMax, 0, 0) * Vector3(0, 0, 2))
			A = (t.pitch.position + (t.yaw.rotation * pitchMax))
			B = (t.pitch.position + (t.yaw.rotation * pitchMin))
			Handles.Label(A, 'Max Pitch')
			Handles.Label(B, 'Min Pitch')
			Handles.DrawLine(A, (t.pitch.position + (t.yaw.rotation * (pitchMax * 10))))
			Handles.DrawLine(B, (t.pitch.position + (t.yaw.rotation * (pitchMin * 10))))
			t.pitchMax = Mathf.Repeat(Handles.ScaleValueHandle(t.pitchMax, A, Quaternion.LookRotation(t.pitch.up), 1, Handles.SphereCap, 0.10000000149F), 360.0F)
			t.pitchMin = Mathf.Repeat(Handles.ScaleValueHandle(t.pitchMin, B, Quaternion.LookRotation(t.pitch.up), 1, Handles.SphereCap, 0.10000000149F), 360.0F)
		
		if GUI.changed:
			EditorUtility.SetDirty(t)

