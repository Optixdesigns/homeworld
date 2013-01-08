/// <Licensing>
/// © 2011 (Copyright) Path-o-logical Games, LLC
/// If purchased from the Unity Asset Store, the following license is superseded 
/// by the Asset Store license.
/// Licensed under the Unity Asset Package Product License (the "License");
/// You may not use this file except in compliance with the License.
/// You may obtain a copy of the License at: http://licensing.path-o-logical.com
/// </Licensing>
using UnityEditor;
using UnityEngine;
using System.Collections;


[CustomEditor(typeof(TargetTracker))]
public class TargetTrackerInspector : Editor
{
    private bool showPerimeter = true;

	public override void OnInspectorGUI()
	{
        var script = (TargetTracker)target;

        EditorGUI.indentLevel = 1;
        PGEditorUtils.LookLikeControls();
        script.numberOfTargets = EditorGUILayout.IntField("Targets (-1 for all)", script.numberOfTargets);
        script.targetLayers = PGEditorUtils.LayerMaskField("Target Layers", script.targetLayers);
        //script.sortingStyle = PGEditorUtils.EnumPopup<TargetTracker.SORTING_STYLES>("Sorting Style", script.sortingStyle);

        EditorGUI.indentLevel = 0;
        this.showPerimeter = EditorGUILayout.Foldout(this.showPerimeter, "Perimeter Settings");

        if (this.showPerimeter)
        {
            EditorGUI.indentLevel = 2;
            script.perimeterLayer = EditorGUILayout.LayerField("Perimeter Layer", script.perimeterLayer);

            //EditorGUILayout.BeginHorizontal();

            //GUILayout.Label("Gizmo", GUILayout.MaxWidth(40));
            script.drawGizmo = EditorGUILayout.Toggle("Show Gizmo", script.drawGizmo);
            //EditorGUILayout.EndHorizontal();

            script.range = EditorGUILayout.FloatField("Range", script.range);
        }
        EditorGUI.indentLevel = 1;


        GUILayout.Space(4);
        script.debugLevel = (DEBUG_LEVELS)EditorGUILayout.EnumPopup("Debug Level", (System.Enum)script.debugLevel);


        // Flag Unity to save the changes to to the prefab to disk
        if (GUI.changed)
            EditorUtility.SetDirty(target);
    }
}
