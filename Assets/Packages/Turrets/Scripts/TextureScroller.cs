using UnityEngine;
using System.Collections;

public class TextureScroller : MonoBehaviour {
	
	public Vector2 direction = new Vector2(0,1);
	
	IEnumerator Start () {
		var mat = renderer.material;
		while(true) {
			mat.mainTextureOffset += direction * Time.deltaTime;
			yield return null;
		}
	}
	
	
}
