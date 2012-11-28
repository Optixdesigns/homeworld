using UnityEngine;
using System.Collections;

[RequireComponent(typeof(SphereCollider), typeof(Rigidbody))]
public class SimpleProjectile : Weapon
{
	public float initialSpeed = 10;
	public GameObject explosion;
	public float life = 5;
	public Vector3 spin = Vector3.zero;
	public float damageRadius = 5;

	void Start ()
	{
		rigidbody.velocity = transform.forward * initialSpeed;
		Destroy (gameObject, life);
		rigidbody.constraints = RigidbodyConstraints.FreezeRotation;
	}
	
	void Update ()
	{
		transform.Rotate (spin * Time.deltaTime);	
	}

	void OnCollisionEnter (Collision collision)
	{
		var c = collision.contacts [0];
		if (explosion != null)
			Instantiate (explosion, c.point, Quaternion.FromToRotation (Vector3.up, c.normal));
		var hits = Physics.OverlapSphere (transform.position, damageRadius);
		foreach (var hit in hits) {
			var delta = (hit.transform.position - transform.position).magnitude / damageRadius;
            hit.transform.SendMessage("ApplyDamage", baseDamage * delta, SendMessageOptions.DontRequireReceiver);
		}
		Destroy (gameObject);
	}
	
}
