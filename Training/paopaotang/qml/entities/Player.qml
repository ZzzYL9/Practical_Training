import QtQuick 2.0
import Felgo 3.0

EntityBase {
    id: player
    entityType: "player"
    width: 20
    height: 20

    property alias collider: collider
    property alias horizontalVelocity: collider.linearVelocity.x
    property alias verticalVelocity: collider.linearVelocity.y
    property alias playerimage: playerima.source

    MultiResolutionImage {
        id: playerima
        width:20
        height: 20
        source: "../../assets/player/p1_11.png"
    }

    BoxCollider {
        id: collider
        height: parent.height
        width: 20
        anchors.horizontalCenter: parent.horizontalCenter
        // this collider must be dynamic because we are moving it by applying forces and impulses
        bodyType: Body.Dynamic // this is the default value but I wanted to mention it ;)
        fixedRotation: true // we are running, not rolling...
        bullet: true // for super accurate collision detection, use this sparingly, because it's quite performance greedy
        sleepingAllowed: false
        // apply the horizontal value of the TwoAxisController as force to move the player left and right
        force: Qt.point(controller.xAxis*170*32,-controller.yAxis*170*32)

        // limit the horizontal velocity
        onLinearVelocityChanged: {
          if(linearVelocity.x > 170) linearVelocity.x = 170
          if(linearVelocity.x < -170) linearVelocity.x = -170
          if(linearVelocity.y > 170) linearVelocity.y = 170
          if(linearVelocity.y < -170) linearVelocity.y = -170

        }
    }

    // this timer is used to slow down the players horizontal movement. the linearDamping property of the collider works quite similar, but also in vertical direction, which we don't want to be slowed
    Timer {
    id: updateTimer
    // set this interval as high as possible to improve performance, but as low as needed so it still looks good
    interval: 10
    running: true
    repeat: true
    onTriggered: {
      var xAxis = controller.xAxis;
      // if xAxis is 0 (no movement command) we slow the player down until he stops
      if(xAxis == 0) {
        if(Math.abs(player.horizontalVelocity) > 10) player.horizontalVelocity /= 1.5
        else player.horizontalVelocity = 0
      }
      var yAxis = controller.yAxis;
      // if xAxis is 0 (no movement command) we slow the player down until he stops
      if(yAxis == 0) {
        if(Math.abs(player.verticalVelocity) > 10) player.verticalVelocity /= 1.5
        else player.verticalVelocity = 0
      }
    }
    }

    function left_change(){
        playerimage = "../../assets/player/p2_11.png"
    }
    function right_change(){
        playerimage = "../../assets/player/p1_11.png"
    }
    function top_change(){
        playerimage = "../../assets/player/p3_11.png"
    }
    function down_change(){
        playerimage = "../../assets/player/p4_11.png"
    }

    function boom(){

    }

}

