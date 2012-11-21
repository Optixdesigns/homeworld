using UnityEngine;
using System.Collections;

[USequencerEvent("Sequence/Stop Sequence")]
public class USstopSequenceEvent : USEventBase 
{
	public USSequencer sequence = null;
	
	public override void FireEvent()
	{	
		if(!sequence)
			Debug.LogWarning("No sequence for USstopSequenceEvent : " + name, this);
		
		if (sequence)
			sequence.Stop();
	}
	
	public override void ProcessEvent(float deltaTime)
	{
		
	}
}
