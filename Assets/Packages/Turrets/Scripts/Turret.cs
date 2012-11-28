using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class Turret : MonoBehaviour
{
    public Transform target;
    public Transform targetPrefab;
    public Transform pivot;
    public Transform yaw;
    public Transform pitch;
    public Transform[] barrels;
    public bool allBarrels = true;
    public float barrelDelay = 0.5f;
    public int burst = 1;
    public float yawRange = 90;
    public float pitchMin = 5;
    public float pitchMax = 45;
    public bool limitYaw = false;
    public float yawSpeed = 10;
    public float pitchSpeed = 10;
    public float recoilLength = 1;
    public float accuracy = 0;
    public float dampSpeed = 0.1f;
    public float speedRecoil = 5.0f;
    float yawVelocity;
    float pitchVelocity;
    Vector3[] barrelPositions;
    public AudioClip shootingClip;
    public float shootingClipDistance = 10;
    public float shootAudioPredelay = 0;
    public GameObject projectilePrefab;
    public AudioClip moveStart, moveLoop, moveEnd;
    public float movingClipDistance = 10;
    AudioSource fx, loop, shoot;
    public bool autoFire = true;
    public float coolDown = 2;
    
    float heat;
    Vector3 restAngles;
    List<Transform> targets = new List<Transform> ();
    public float speedFactor = 1;
    public float fireRateFactor = 1;
    public TurretGroup turretGroup;

    public int TargetCount {
        get {
            return targets.Count;        
        }
    }
 
    void Awake ()
    {
        barrelPositions = new Vector3[barrels.Length];
        for (int i = 0; i < barrels.Length; i++) {
            barrelPositions [i] = barrels [i].localPosition;
        }
        SetupAudio ();
    }

 
    void SetupAudio ()
    {
        fx = gameObject.AddComponent<AudioSource> ();
        loop = gameObject.AddComponent<AudioSource> ();
        shoot = gameObject.AddComponent<AudioSource> ();
        fx.playOnAwake = loop.playOnAwake = shoot.playOnAwake = false;
        loop.clip = moveLoop;
        loop.loop = true;
        fx.minDistance = loop.minDistance = movingClipDistance;
        shoot.minDistance = shootingClipDistance;
    }

    bool AngleInRange (float A, float D)
    {
        if (A < (360 - D) && A > 180) {
            return false;
        }
        if (A > D && A < 180) {
            return false;
        }
        return true;
    }

    bool AngleBetween (float angle, float A, float B)
    {
        angle = (360 + angle % 360) % 360;
        A = (360 + A % 360) % 360;
        B = (360 + B % 360) % 360;
        if (A < B)
            return A <= angle && angle <= B;
        return A <= angle || angle <= B;
    }

    public bool CanYawTarget (Vector3 position)
    {
        if (limitYaw) {
            var delta = (position - yaw.position);
            var rot = Quaternion.FromToRotation (pivot.forward, delta).eulerAngles;
            Debug.Log (rot.y);
            return AngleBetween (rot.y, -yawRange, yawRange);
        }
        return true;
    }
     
    public bool CanPitchTarget (Vector3 position)
    {
     
        var delta = (position - pitch.position);
        var rot = Quaternion.FromToRotation (yaw.forward, delta).eulerAngles;
        return AngleBetween (rot.x, pitchMin, pitchMax);
    }

    void Update ()
    {
        heat -= Time.deltaTime * fireRateFactor;
     
        if (target == null && targets.Count > 0) {
            target = targets.Pop (0);
        }

        if (target != null) {
            var E = yaw.localEulerAngles;
            var targetYaw = E.y;
            if (CanYawTarget (target.position)) {
                var LP = transform.InverseTransformPoint (target.position);
                var A = Vector3.Angle (new Vector3 (LP.x, 0, LP.z), Vector3.forward);
                targetYaw = A * (LP.x < 0 ? -1 : 1);
                E.y = Mathf.SmoothDampAngle (E.y, targetYaw, ref yawVelocity, dampSpeed, yawSpeed * speedFactor);
                yaw.localEulerAngles = E;

            }
            if (CanPitchTarget (target.position)) {
                if (Mathf.Abs (Mathf.DeltaAngle (E.y, targetYaw)) < 30) {
                    var LP = yaw.InverseTransformPoint (target.position + (Vector3.down * pitch.localPosition.y));
                    var A = Vector3.Angle (new Vector3 (0, LP.y, LP.z), Vector3.forward);
                    var PE = pitch.localEulerAngles;
                    var targetPitch = -A * (LP.y < 0 ? -1 : 1);
                    PE.x = Mathf.SmoothDampAngle (PE.x, targetPitch, ref pitchVelocity, dampSpeed, pitchSpeed * speedFactor);
                    pitch.localEulerAngles = PE;
                }
            }
            UpdateSound (Mathf.Abs (yawVelocity) + Mathf.Abs (pitchVelocity));
            for (int i = 0; i < barrels.Length; i++) {
                barrels [i].localPosition = Vector3.Lerp (barrels [i].localPosition, barrelPositions [i], Time.deltaTime * speedRecoil);
            }
            accuracy = Vector3.Angle (pitch.forward, target.position - pitch.position);
        } else {
            UpdateSound (0); 
        }

        if (target != null && accuracy <= 0.5f) {
            Fire (projectilePrefab);
        }


     
     
    }

    public bool Fire ()
    {
        return Fire (projectilePrefab);
    }

    public bool Fire (GameObject projectilePrefab)
    {
        if (heat > 0)
            return false;
     
        StartCoroutine (_Fire (projectilePrefab));
        return true;     
    }
 
    IEnumerator _Fire (GameObject projectilePrefab)
    {
        for (var b=0; b<burst; b++) {
            heat = coolDown + (Random.value * coolDown);
            if (allBarrels) {
                if (shootingClip != null) {
                    shoot.PlayOneShot (shootingClip);
                }
                yield return new WaitForSeconds(shootAudioPredelay);
                for (int i = 0; i < barrels.Length; i++) {
                    var proj = Instantiate (projectilePrefab, barrels [i].position + (projectilePrefab.transform.localScale.z * barrels [i].forward), barrels [i].rotation) as GameObject;
                    barrels [i].localPosition = barrelPositions [i] - new Vector3 (0, 0, recoilLength);
                }
            } else {

                for (int i = 0; i < barrels.Length; i++) {
                    if (shootingClip != null) {
                        shoot.PlayOneShot (shootingClip);
                    }
                    yield return new WaitForSeconds(shootAudioPredelay);
                    Instantiate (projectilePrefab, barrels [i].position + (projectilePrefab.transform.localScale.z * barrels [i].forward), barrels [i].rotation);
                    barrels [i].localPosition = barrelPositions [i] - new Vector3 (0, 0, recoilLength);
                    yield return new WaitForSeconds(barrelDelay);
                }
            }
        }
     
    }

    public bool CanTarget (Vector3 position)
    {
        return CanPitchTarget (position) && CanYawTarget (position);
    }

    bool moving = false;

    void UpdateSound (float movement)
    {
        if (movement > 1.5f) {
            if (moving) {
                if (!loop.isPlaying)
                    loop.Play ();
            } else {
                moving = true;
                audio.PlayOneShot (moveStart);
            }

        } else {
            if (moving) {
                loop.Stop ();
                audio.PlayOneShot (moveEnd);
                moving = false;
            }

        }
    }
 
    public void AddTarget (Vector3 point)
    {
        if (CanTarget (point)) {
            if (targets.Count > 5) {
                var t = targets.Pop (0);
                Destroy (t.gameObject);
            }
            targets.Add (Instantiate (targetPrefab, point, Quaternion.identity) as Transform);
        }
    }


 
}
