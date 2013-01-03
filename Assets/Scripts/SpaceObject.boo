import UnityEngine


enum SpaceObjectType:
    Ship
    Asteroid


class SpaceObject(MonoBehaviour): 
    public _name as string
    public type as SpaceObjectType
