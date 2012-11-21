using UnityEditor;
using UnityEngine;

/// <summary>
/// This class does nothing other than reverts changes we made to objects with the uSequencer back to their
/// original state, this is so we don't save our current properties, we want to save the default properties.
/// </summary>
public class USAssetModificationProcessor : AssetModificationProcessor 
{
	// Use this for initialization
	static void OnWillSaveAssets (string[] paths)
	{
        foreach(string path in paths)
        {
            if(path.Contains(".unity"))
            {
				USControl.StopProcessingAnimationMode();
				USControl.RevertEditorData();
			}
		}
	}
}
