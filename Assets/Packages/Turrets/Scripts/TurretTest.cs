using UnityEngine;
using System.Collections;

public class TurretTest : MonoBehaviour {
	void OnGUI() {
		if(GUI.Button(new Rect(10,10,100,100), "Fire!")) {
			GetComponent<Turret>().Fire();	
		}
		
	}
}
