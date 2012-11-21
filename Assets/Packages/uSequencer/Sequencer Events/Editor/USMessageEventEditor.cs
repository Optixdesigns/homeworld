using UnityEditor;
using UnityEngine;
using System.Collections;

[CustomEditor(typeof(USMessageEvent))]
public class USMessageEventEditor : USEventBaseEditor
{
	new public Rect RenderEvent(Rect myArea, USEventBase thisEvent)
	{
		USMessageEvent messageEvent = thisEvent as USMessageEvent;

		if (!messageEvent)
			Debug.LogWarning("Trying to render an event as a USMessageEvent, but it is a : " + thisEvent.GetType().ToString());

		DrawDefaultBox(myArea, thisEvent);

		GUILayout.BeginArea(myArea);
			GUILayout.Label("Write To Log :", defaultBackground);
			if (messageEvent)
				GUILayout.Label(messageEvent.message, defaultBackground);
		GUILayout.EndArea();

		return myArea;
	}
}
