import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, server is running!"
    }
    
    let usersController = UsersController()
    try router.register(collection: usersController)

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)

    let mkComicController = MKComicController()
    router.get("comics", use: mkComicController.index)
    router.get("comics", Int.parameter, use: mkComicController.one)
    
    let mkCharacterController = MKCharacterController()
    router.get("characters", use: mkCharacterController.index)
    router.get("characters", Int.parameter, use: mkCharacterController.one)
    router.get("characters", Int.parameter, "comics", use: mkCharacterController.comics)
    router.get("characters", Int.parameter, "series", use: mkCharacterController.series)
    router.get("characters", Int.parameter, "stories", use: mkCharacterController.one)
    router.get("characters", Int.parameter, "events", use: mkCharacterController.one)

    let mkEventController = MKEventController()
    router.get("events", use: mkEventController.index)
    router.get("events", Int.parameter, use: mkEventController.one)

    let mkStoryController = MKStoryController()
    router.get("stories", use: mkStoryController.index)
    router.get("stories", Int.parameter, use: mkStoryController.one)

    let mkSeriesController = MKSeriesController()
    router.get("series", use: mkSeriesController.index)
    router.get("series", Int.parameter, use: mkSeriesController.one)
    router.get("series", Int.parameter, "comics", use: mkSeriesController.comics)

    let mkCreatorController = MKCreatorController()
    router.get("creators", use: mkCreatorController.index)
    router.get("creators", Int.parameter, use: mkCreatorController.one)
    router.get("creators", Int.parameter, "comics", use: mkCreatorController.comics)
    router.get("creators", Int.parameter, "series", use: mkCreatorController.series)
    router.get("creators", Int.parameter, "events", use: mkCreatorController.events)
}
