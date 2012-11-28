using UnityEngine;
using System.Collections;

public class RailGunAnimation : MonoBehaviour
{
	public Vector2 scroll = Vector3.zero;
	public Color targetColor;
	public float speed, spinSpeed;
	
	IEnumerator Start ()
	{
		var mat = renderer.material;
		var startColor = mat.GetColor ("_TintColor");
		var D = 0f;
		while (true) {
			yield return null;
			mat.mainTextureOffset += scroll * Time.deltaTime;
			mat.SetColor ("_TintColor", Color.Lerp (startColor, targetColor, D));
			transform.Rotate(0,0,Time.deltaTime*spinSpeed);
			D += Time.deltaTime / speed;
			if (D >= 1)
				break;
		}
		
		if (transform.parent != null)
			Destroy (transform.parent.gameObject);
		else
			Destroy (gameObject);
	
	}
	
	
}
