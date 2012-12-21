//
// Methodic.cs
//
// Author: Matthew Miner (matthew@matthewminer.com)
// Copyright (c) 2011
//

using UnityEditor;
using UnityEngine;
using System;
using System.Collections.Generic;
using System.Reflection;

/// <summary>
/// Displays a dropdown menu of functions available for the selected game object to access.
/// </summary>
public class Methodic : EditorWindow
{
	/// <summary>
	/// The version of Methodic.
	/// </summary>
	public static readonly Version version = new Version(1, 0, 1);
	
	/// <summary>
	/// The website to visit for information.
	/// </summary>
	public const string website = "http://www.matthewminer.com/";
	
	/// <summary>
	/// Holds method info and its parent component.
	/// </summary>
	class Method
	{
		readonly Component component;
		readonly MethodInfo method;
		readonly MethodicParameters parameters;
		
		/// <summary>
		/// Whether the method accepts any parameters.
		/// </summary>
		public bool hasParameters {
			get { return method.GetParameters().Length > 0; }
		}
		
		/// <summary>
		/// The name of the method.
		/// </summary>
		public string name {
			get { return method.Name; }
		}
		
		/// <summary>
		/// Creates a new Method instance.
		/// </summary>
		/// <param name="component">The component the scripts are attached to.</param>
		/// <param name="method">The method.</param>
		public Method (Component component, MethodInfo method)
		{
			this.component = component;
			this.method = method;
			this.parameters = new MethodicParameters(method);
		}
		
		/// <summary>
		/// Displays a form where parameters can be modified.
		/// </summary>
		public void DisplayParametersForm ()
		{
			parameters.OnGUI();
		}
		
		/// <summary>
		/// Executes the method.
		/// </summary>
		public void Invoke ()
		{
			try {
				var result = method.Invoke(component, parameters.parameters);
				
				// Display the return value if one is expected
				if (method.ReturnType != typeof(void)) {
					Debug.Log("[Methodic] Result: " + result);
				}
			} catch (ArgumentException e) {
				Debug.LogError("[Methodic] Unable to invoke method: " + e.Message);
			}
		}
	}
	
	enum Panel { Main, Options }
	
	static readonly GUIContent optionsLabel = new GUIContent("Options", "Customize which methods are shown.");
	static readonly GUIContent popupLabel = new GUIContent("Method");
	static readonly GUIContent invokeLabel = new GUIContent("Invoke", "Execute this method.");
	
	Panel selectedPanel;
	Method[] methods = {};
	GUIContent[] methodLabels = {};
	int methodIndex;
	
	Method selectedMethod {
		get {
			if (methodIndex >= 0 && methodIndex < methods.Length) {
				return methods[methodIndex];
			} else {
				return null;
			}
		}
	}
	
	/// <summary>
	/// Adds Methodic to Window menu.
	/// </summary>
	[MenuItem ("Window/Methodic %#m")]
	static void Init ()
	{
		// Get existing open window, or make new one if none
		GetWindow<Methodic>();
	}
	
	void OnGUI ()
	{
		// Toolbar
		EditorGUILayout.BeginHorizontal(EditorStyles.toolbar);
		
			GUILayout.FlexibleSpace();	
			
			var optionsToggle = GUILayout.Toggle(selectedPanel == Panel.Options, optionsLabel, EditorStyles.toolbarButton);
			selectedPanel = optionsToggle ? Panel.Options : Panel.Main;
		
		EditorGUILayout.EndHorizontal();
		
		// Panel
		switch (selectedPanel) {
			case Panel.Main:
				GUI.enabled = selectedMethod != null;
				EditorGUILayout.BeginHorizontal();
					
					methodIndex = EditorGUILayout.Popup(popupLabel, methodIndex, methodLabels);
					
					if (GUILayout.Button(invokeLabel, EditorStyles.miniButton, GUILayout.ExpandWidth(false))) {
						Undo.RegisterSceneUndo(selectedMethod.name + " Call");
						selectedMethod.Invoke();
					}
				
				EditorGUILayout.EndHorizontal();
				
				if (selectedMethod != null && selectedMethod.hasParameters) {
					MethodicUtil.DrawDivider();
					selectedMethod.DisplayParametersForm();
				}
			
				GUI.enabled = true;
				break;
			
			case Panel.Options:
				MethodicOptions.OnGUI();
				break;
		}
	}
	
	void OnSelectionChange ()
	{
		DiscoverMethods();
	}
	
	/// <summary>
	/// Discovers the selected game object's methods and refreshes the GUI.
	/// </summary>
	public void DiscoverMethods ()
	{
		var target = Selection.activeGameObject;
		var methods = new List<Method>();
		var methodLabels = new List<GUIContent>();
		
		if (target != null) {
			// Discover methods in attached components
			foreach (var component in target.GetComponents<MonoBehaviour>()) {
				var type = component.GetType();
				var allMethods = type.GetMethods(MethodicOptions.flags);
				
				foreach (var method in allMethods) {
					methods.Add(new Method(component, method));
					var label = new GUIContent("", method.ToString());
					
					if (MethodicOptions.displayClass) {
						label.text = component.GetType() + ": ";
					}
					
					label.text += method.Name;
					methodLabels.Add(label);
				}
			}
		}
		
		this.methods = methods.ToArray();
		this.methodLabels = methodLabels.ToArray();
		this.methodIndex = 0;
		Repaint();
	}
}