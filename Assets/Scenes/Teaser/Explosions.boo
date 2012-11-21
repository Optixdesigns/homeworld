import UnityEngine

class Explosions (MonoBehaviour): 
    public detonatorPrefabs as (GameObject) = array(GameObject, 0)
    public explosionLife as single = 10
    #public spawnTime as single = 10

    private curDetonator as GameObject
    private spawnBounds as Bounds
    private lastExplosion as single = 0

    def Start():
        spawnBounds = collider.bounds
        SpawnExplosion()
    
    def Update ():
        lastExplosion += 1

        if lastExplosion >= 40:
            lastExplosion = 0
            SpawnExplosion()


    def SpawnExplosion():
        curDetonator = detonatorPrefabs[Random.Range(0, detonatorPrefabs.Length)]
        curDetonator.GetComponent(Detonator).size = Random.Range(10, 1000)
        exp as GameObject = Instantiate(curDetonator, GetRandomPosition(), Quaternion.identity)
        exp.transform.parent = transform
        Destroy(exp, explosionLife)

    def GetRandomPosition() as Vector3:
        position as Vector3 = Vector3(Random.Range(spawnBounds.min.x, spawnBounds.max.x), Random.Range(spawnBounds.min.y, spawnBounds.max.y), Random.Range(spawnBounds.min.z, spawnBounds.max.z))
        return position

