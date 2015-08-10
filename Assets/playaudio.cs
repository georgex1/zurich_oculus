using UnityEngine;
using System.Collections;

public class playaudio : MonoBehaviour {
	public AudioSource audioinicio;
	public AudioClip audiofile;

	// Use this for initialization
	void Start () {
		//audio.PlayDelayed(5);

		audioinicio = (AudioSource)gameObject.AddComponent ("AudioSource");
		AudioClip myAudioClip;

		audioinicio.clip = audiofile;
		audioinicio.loop = false;
		audioinicio.PlayDelayed (3);
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
