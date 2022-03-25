import Vapor

func routes(_ app: Application) throws {
    
        //QUERY STRING
        // /search?planet=earth&galaxy=andromeda
        app.get("search"){ req -> String in
    
            guard let planet = req.query["planet"] as String?,
                  let galaxy = req.query["galaxy"] as String? else{
                throw Abort(.badRequest)
            }
    
            return "You're looking for :\n   galaxy: \(galaxy)   \n   planet: \(planet)\nAll operator are busy to replying people more important than you now, try again in 126 years"
    
        }

        //index page return html
        app.get{ req -> String in
            return "This is an index page!"
        }
    
        //simple req
        app.get("space") { req -> String in
            return "Space"
        }
    
        // nested req
        app.get("space",":galaxy") { req -> String in
            guard let galaxy = req.parameters.get("galaxy") else{
                throw Abort(.badRequest)
            }
            return "You are looking \(galaxy)!"
        }
    
        // multi nested req
        app.get("space",":galaxy",":planet"){ req -> String in
            guard let galaxy = req.parameters.get("galaxy"),
                  let planet = req.parameters.get("planet") else{
                        throw Abort(.badRequest)
                  }
            return "You are visiting \(planet), in \(galaxy) galaxy!"
        }
    
        //anithing routes
        //space/<nomeacasaccio>/details
        app.get("space","*","details"){ req -> String in
    
            return "Soon more datails about this planet!"
    
        }
    
        //catchall routes
        app.get("**"){ req -> String in
    
            return "Gotta cath'em all!"
    
        }
    
        //ROUTE GROUPS
        //planets
        //planets/jupter
        //planet/mars
        //planet/earth ...
    
        let planets = app.grouped("planets")
    
        planets.get{ req -> String in
            return "Planets page!"
        }
        planets.get(":name"){ req -> String in
            guard let planet = req.parameters.get("name") else{
                throw Abort(.badRequest)
            }
            return "\(planet) page!"
        }
}
