import UnityEngine


public class Attack:
    /*-----------------------------------------------------------------------------
        Name        : attackSimple
        Description : simplest attack possible, attacks target without turning or anything
        Inputs      : ship, target
        Outputs     :
        Return      :
    ----------------------------------------------------------------------------*/
    #def Simple(ship as Ship, target as SpaceObjRotImpTarg):
    def Simple(ship as ShipController):
        #vector trajectory;
        range as single
        dist as single
        temp as single
        /*
        aishipGetTrajectory(ship,(SpaceObjRotImpTarg *)target,&trajectory);

        dist = fsqrt(vecMagnitudeSquared(trajectory));
        vecDivideByScalar(trajectory,dist,temp);

        range = RangeToTargetGivenDist(ship,(SpaceObjRotImpTarg *)target,dist);
        gunShootGunsAtTarget(ship,(SpaceObjRotImpTarg *)target,range,&trajectory);
        ship->shipisattacking = FALSE;      // we're not attacking, just blowing stuff up in our way
        */