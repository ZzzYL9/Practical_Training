import QtQuick 2.0
import Felgo 3.0

EntityBase{
    id:flower
    entityType: "flower"

    property int column: 0
    property int row: 0
    property int size // gets set in Platform.qml and Ground.qml

    TexturePackerAnimatedSprite {
      id: flowerimg
      x:-8
      y:-12
      width: 40
      height: 40
      running: true
      source: "../../../assets/flower/flower.json"
      frameNames: ["flower1.png", "flower2.png", "flower3.png", "flower4.png", "flower5.png", "flower6.png", "flower7.png", "flower8.png", "flower9.png", "flower10.png"]
//      anchors.fill: parent
      frameRate: 5
    }

    CircleCollider{
        radius: parent.width/2
        anchors.centerIn: parent
        bodyType: Body.Static
        categories: Circle.Category3
        collidesWith: Circle.Category1 | Circle.Category4 | Circle.Category5 | Circle.Category6 | Circle.Category7
    }

    x: row * gameScene.gridSize
    y: scene.height - (column+1)*gameScene.gridSize
    width: gameScene.gridSize * size
    height: gameScene.gridSize
}
