import QtQuick 2.0
import Felgo 3.0

EntityBase {
    id:fire1
    entityType: "fire1"
    width: 15;height: 15

    MultiResolutionImage {
        id: fireimage1
        width: 15;height: 15
        source: "../../assets/fire/fireleft.png"
    }

    Timer{
        id:removeF1
        interval: 2500
        running: true
        repeat: false
        onTriggered: {
            fire1.removeEntity()
        }
    }

    // these values can then be set when a new projectile is created in the MouseArea below
    property point destination
    property point initpoint
    property int moveDuration

    PropertyAnimation on x {
      from: initpoint.x
      to: destination.x
      duration: moveDuration
    }

    PropertyAnimation on y {
      from: initpoint.y
      to: destination.y
      duration: moveDuration
    }

    CircleCollider {
        radius: fireimage1.width/2
//        width: 15
//        height: 15
        anchors.centerIn: parent
//        anchors.fill: fireimage1
        collisionTestingOnlyMode: true

        //碰撞检测
        fixture.onBeginContact: {

          // if the collided type was a projectile, both can be destroyed and the player gets a point
          var collidedEntity = other.getBody().target
          console.debug("collided with entity", collidedEntity.entityType)
          // monsters could also collide with other monsters because they have a random speed - alternatively, collider categories could be used
          if(collidedEntity.entityType === "box" || collidedEntity.entityType === "obstacle3") {
//            monstersDestroyed++
            // remove the projectile entity
            collidedEntity.removeEntity()
            // remove the monster
            removeEntity()
          }
        }
    }
}
