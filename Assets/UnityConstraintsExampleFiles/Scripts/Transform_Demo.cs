using UnityEngine;
using System.Collections;

public class Transform_Demo : MonoBehaviour
{

    private Transform xform;
    private bool moveForward = true;
    private float speed = 5f;
    private float duration = 0.6f;
    private float delay = 1.5f;

    Vector3 bigScale = new Vector3(2, 2, 2);
    Vector3 smallScale = new Vector3(1, 1, 1);

    void Awake()
    {
        this.xform = this.transform;
    }

	// Use this for initialization
	void Start () {
        this.StartCoroutine(this.MoveTarget());
        this.StartCoroutine(this.RotateTarget());
	}

    private IEnumerator RotateTarget()
    {
        yield return new WaitForSeconds(delay);

        while (true)
        {
            this.xform.Rotate(0, 3, 0);
            yield return null;
        }
    }

    private IEnumerator MoveTarget()
    {
        yield return new WaitForSeconds(delay);

        float savedTime = Time.time;

        while ((Time.time - savedTime) < duration)
        {
            if (moveForward)
            {
                this.xform.Translate(Vector3.up * (Time.deltaTime * speed));
                this.xform.localScale = Vector3.Lerp(this.xform.localScale, bigScale, (Time.deltaTime * 4.75f));
            }
            else
            {
                this.xform.Translate(Vector3.down * (Time.deltaTime * speed));
                this.xform.localScale = Vector3.Lerp(this.xform.localScale, smallScale, (Time.deltaTime * 4.75f));
            }
            yield return null;
        }

        moveForward = moveForward ? false : true;

        this.StartCoroutine(MoveTarget());
    }
}
