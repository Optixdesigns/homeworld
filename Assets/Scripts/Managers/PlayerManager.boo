import UnityEngine


class PlayerManager(MonoBehaviour):
    public playerPrefab as GameObject
    public players as (GameObject) = array(GameObject, 0)

    def Start ():
        pass
    
    def Update ():
        pass

    def CreatePlayer():
       /// Create a player instance
       player = Instantiate(playerPrefab, transform.position, transform.rotation)
       player.transform.parent = transform
       return player

    # TODO CHECK IF VALUES EXIST IN OTHER PLAYER PROFILES
    def GenerateRandomPlayer():
        pass
        #obj = CreatePlayer()
        #player = obj.GetComponent("PlayerController")
        #player.SetPlayerName("jan")