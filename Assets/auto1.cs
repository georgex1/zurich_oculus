using UnityEngine;
using System.Collections;

public class auto1 : MonoBehaviour {

	// Use this for initialization
	void Start () {
		iTween.MoveTo(gameObject, iTween.Hash("path", iTweenPath.GetPath("Auto1"), "time", 20, "looptype", "loop"));
	}
	

}
