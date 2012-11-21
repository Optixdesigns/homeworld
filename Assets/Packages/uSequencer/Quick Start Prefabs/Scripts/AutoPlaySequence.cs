using UnityEngine;
using System.Collections;

public class AutoPlaySequence : MonoBehaviour 
{
	public USSequencer sequence = null;
	
	// Use this for initialization
	void Start () 
	{
		if(!sequence)
		{
			Debug.LogError("You have added an AutoPlaySequence, however you haven't assigned it a sequence", gameObject);
			return;
		}
		
		if(sequence)
			sequence.Play();
	}
}
