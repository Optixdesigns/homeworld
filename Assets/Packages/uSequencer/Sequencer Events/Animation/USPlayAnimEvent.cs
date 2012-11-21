using UnityEngine;
using System.Collections;

[USequencerEvent("Animation/Play Animation")]
public class USPlayAnimEvent : USEventBase {
	public AnimationClip animationClip = null;

    public WrapMode wrapMode;
	
	public void Update() 
	{
        if (wrapMode != WrapMode.Loop && animationClip)
			Duration = animationClip.length;
	}
	
	public override void FireEvent()
	{
		if(!animationClip)
		{
			Debug.Log("Attempting to play an animation on a GameObject but you haven't given the event an animation clip from USPlayAnimEvent::FireEvent");
			return;
		}
		
		Animation animation = AffectedObject.GetComponent<Animation>();
		if(!animation)
		{
			Debug.Log("Attempting to play an animation on a GameObject without an Animation Component from USPlayAnimEvent.FireEvent");
			return;
		}

        animation.wrapMode = wrapMode;
        animation.Play(animationClip.name);
	}
	
	public override void ProcessEvent(float deltaTime)
	{
		Animation animation = AffectedObject.GetComponent<Animation>();

		if (!animation)
		{
			Debug.LogError("Trying to play an animation : " + animationClip.name + " but : " + AffectedObject + " doesn't have an animation component, we will add one, this time, though you should add it manually");
			animation = AffectedObject.AddComponent<Animation>();
		}

		if (animation[animationClip.name] == null)
		{
			Debug.LogError("Trying to play an animation : " + animationClip.name + " but it isn't in the animation list. I will add it, this time, though you should add it manually.");
			animation.AddClip(animationClip, animationClip.name);
		}

		AnimationState state = animation[animationClip.name];

        if (!animation.IsPlaying(animationClip.name))
        {
            animation.wrapMode = wrapMode;
            animation.Play(animationClip.name);
        }

		state.time = deltaTime;
		state.enabled = true;
		animation.Sample();
		state.enabled = false;
	}
	
	public override void StopEvent()
	{
		Animation animation = AffectedObject.GetComponent<Animation>();
        if (animation)
			animation.Stop();
	}
}
