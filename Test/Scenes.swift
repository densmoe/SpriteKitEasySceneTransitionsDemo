
import SpriteKit

protocol SceneTransitionDelegate {
    func transitionToScene(sceneClass:Scene.Type)
    func transitionToScene(sceneClass:Scene.Type, transitionAnimation:SKTransition)
}

class Scene:SKScene {
    var sceneDelegate:SceneTransitionDelegate!
    required override init(size: CGSize) {
        super.init(size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GameScene:Scene {
    override func didMoveToView(view: SKView) {
        let label = SKLabelNode(text: "GameScene, tap for gameOver!")
        label.fontSize = 20
        label.position = CGPointMake(frame.midX, frame.midY)
        label.horizontalAlignmentMode = .Center
        addChild(label)
        
        let tap = UITapGestureRecognizer(target: self, action: "gameOverAnimated")
        view.addGestureRecognizer(tap)
    }
    func gameOver() {
        sceneDelegate.transitionToScene(MainMenuScene.self)
    }
    
    func gameOverAnimated() {
        let transition = SKTransition.crossFadeWithDuration(0.5)
        sceneDelegate.transitionToScene(MainMenuScene.self, transitionAnimation: transition)
    }
}

class MainMenuScene: Scene {
    override func didMoveToView(view: SKView) {
        let label = SKLabelNode(text: "MainMenu, tap for newGame!")
        label.fontSize = 20
        label.position = CGPointMake(frame.midX, frame.midY)
        label.horizontalAlignmentMode = .Center
        addChild(label)
        
        let tap = UITapGestureRecognizer(target: self, action: "newGame")
        view.addGestureRecognizer(tap)
    }
    func newGame() {
        sceneDelegate.transitionToScene(GameScene.self)
    }
}