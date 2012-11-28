using UnityEngine;
using System.Collections;

public class LaserProjectile : Weapon
{
    public GameObject extraTrail;
    public GameObject explosion;
    public float life = 5;
    public float damageRadius = 5;
 
    IEnumerator Start ()
    {
        Destroy (gameObject, life);
        var rot = transform.rotation;
        var start = transform.position;
        var fwd = transform.forward;
        RaycastHit hit;
        transform.position = start + fwd;
        yield return null;
        if (extraTrail != null)
            Instantiate (extraTrail, transform.position, rot);
        yield return null;
     
        if (Physics.Raycast (start, fwd, out hit)) {
            transform.position = Vector3.Lerp (start, hit.point, 0.5f);
            yield return null;
            transform.position = hit.point;
            yield return null;
            if (hit.transform == null)
                yield break;
            Damage (hit.point, hit.normal, 1f);
            yield return null;
            var refl = Vector3.Reflect (fwd, hit.normal);
            if (Physics.Raycast (hit.point, refl, out hit)) {
                Damage (hit.point, hit.normal, 0.5f);
            }
            transform.position += refl * 50;
            yield return null;
        } else {
            transform.position += fwd * 50;
            yield return null;
            transform.position += fwd * 150;
            yield return null;
        }
    }
 
    void Damage (Vector3 position, Vector2 up, float damageModifier)
    {
        if (explosion != null)
            Instantiate (explosion, position, Quaternion.FromToRotation (Vector3.up, up));
        var hits = Physics.OverlapSphere (position, damageRadius);
        foreach (var hit in hits) {
            var delta = (hit.transform.position - transform.position).magnitude / damageRadius;
            hit.transform.SendMessage ("ApplyDamage", baseDamage * delta, SendMessageOptions.DontRequireReceiver);
        }
    }
 
}
