using UnityEngine;
using System.Collections;

public class TurretGroup : MonoBehaviour {
	
	public int activeTurret = 0;
	public Turret[] turrets;
	
	public Turret ActiveTurret { 
		get {
			return turrets[activeTurret];		
		}
	}
	
	void Reset () {
		turrets = GetComponentsInChildren<Turret>();	
	}
	
	public void NextTurret() {
		activeTurret = activeTurret + 1;
		activeTurret = activeTurret>=turrets.Length?0:activeTurret;
		ActivateTurret();
	}
	
	public void PrevTurret() {
		activeTurret = activeTurret - 1;
		activeTurret = activeTurret<0?turrets.Length:activeTurret;
		ActivateTurret();
	}
	
	public void ActivateTurret() {
		for(var i=0; i<turrets.Length; i++) {
			turrets[i].gameObject.SetActiveRecursively(i==activeTurret);
		}
	}
	
	public void ActivateTurret(int index) {
		activeTurret = index;
		for(var i=0; i<turrets.Length; i++) {
			turrets[i].gameObject.SetActiveRecursively(i==activeTurret);
		}
	}
	
	void OnEnable () {
		ActivateTurret();	
	}
}
