using UnityEngine;
using System.Collections;

[USequencerEvent("Fullscreen/Print Text")]
public class PrintText : USEventBase 
{
	public string textToPrint = "test";
	private string priorText = "";
	
	public int fontSize = 0;
	
	public float printRatePerCharacter = 0.15f;
	
	public Vector2 pixelOffset = Vector2.zero;
	
	public override void FireEvent()
	{
		if(!AffectedObject.guiText)
			AffectedObject.AddComponent<GUIText>();
		
		priorText = AffectedObject.guiText.text;
		
		AffectedObject.guiText.text = textToPrint;
		AffectedObject.guiText.fontSize = fontSize;
		AffectedObject.guiText.pixelOffset = pixelOffset;
	}
	
	public override void ProcessEvent(float deltaTime)
	{
		if(printRatePerCharacter <= 0.0f)
			AffectedObject.guiText.text = textToPrint;
		else
		{
			int numCharacters = (int)(deltaTime / printRatePerCharacter);
			
			if(numCharacters < textToPrint.Length)
				AffectedObject.guiText.text = textToPrint.Substring(0, numCharacters);
			else
				AffectedObject.guiText.text = textToPrint;
		}
	}
	
	public override void EndEvent()
	{	
		AffectedObject.guiText.text = priorText;
	}
	
	public override void UndoEvent()
	{	
		AffectedObject.guiText.text = priorText;
	}
}
