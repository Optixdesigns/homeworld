using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class TurretAutomator : MonoBehaviour
{
	HashSet<Collider> targets = new HashSet<Collider> ();
	public TurretGroup turretGroup;
	
	void OnTriggerEnter (Collider other)
	{
		if(other.gameObject.CompareTag("Enemy"))
			AddTarget(other);
	}
	
	void OnTriggerStay(Collider other) {
		if(other.gameObject.CompareTag("Enemy"))
			AddTarget(other);	
	}
	
	void AddTarget (Collider other)
	{
		if (turretGroup != null) {
			if (turretGroup.ActiveTurret.TargetCount < 5) {
				var position = other.transform.position;
				turretGroup.ActiveTurret.AddTarget (position);
			}
		}
	}
	
}
