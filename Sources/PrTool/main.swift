//
//  File.swift
//  
//
//  Created by Ondrej Rafaj on 09/06/2019.
//


import GitHubKit


struct Config {
    
    let username: String
    let token: String
    let server: String
    let organization: String
    let repo: String
    let action: String
}

func config() -> Config {
    var username: String?
    var token: String?
    var server: String?
    var organization: String?
    var repo: String?
    var action: String = "print"
    
    var verbose: Bool = false
    
    var previous: String?
    for arg in CommandLine.arguments {
        switch true {
        case previous == "--user" || previous == "-u":
            username = arg
        case previous == "--token" || previous == "-t":
            token = arg
        case previous == "--server" || previous == "-s":
            server = arg
        case previous == "--org" || previous == "-o":
            organization = arg
        case previous == "--repo" || previous == "-r":
            repo = arg
        case previous == "--action" || previous == "-a":
            action = arg
        case arg == "--verbose":
            verbose = true
        case arg == "--help" || arg == "-h":
            print("Arguments:")
            print("    -s [--server] (optional) Enterprise github server URL Ex.:https://github.example.com/api/v3/")
            print("    -t [--token] Personal access token")
            print("    -u [--user] User name")
            print("    -o [--org] Organization")
            print("    -r [--repo] Repo")
            print("    -a [--action] [print|count] (print is default)")
            print("    --verbose Print degub information")
            print("    --help This info")
            print("Use:")
            print("Example usage: pr-count [-s server] -t b27a8...500d -u rafiki270 -o einstore -r speedster")
            exit(0)
        default:
            previous = arg
            continue
        }
        previous = arg
    }
    
    guard let u = username else { fatalError("Missing github username (--help for more)") }
    guard let t = token else { fatalError("Missing personal access token token (--help for more)") }
    guard let o = organization else { fatalError("Missing organization name (--help for more)") }
    guard let r = repo else { fatalError("Missing repo name (--help for more)") }
    
    let s = server ?? "https://api.github.com"
    
    if verbose {
        print("Setup:")
        print("    Server           - \(s)")
        print("    Token            - ****************")
        print("    Username         - \(u)")
        print("    Organization     - \(o)")
        print("    Repo             - \(r)")
    }
    return Config(
        username: u,
        token: t,
        server: s,
        organization: o,
        repo: r,
        action: action
    )
}

let c = config()
let github = try! Github(
    Github.Config(
        username: c.username,
        token: c.token,
        server: c.server
    )
)

func print<C>(codable: C) where C: Codable {
    let jsonData = try! JSONEncoder().encode(codable)
    print(String(data: jsonData, encoding: .utf8)!)
}


let r = try! PR.query(on: github).get(org: c.organization, repo: c.repo).wait()
if c.action == "count" {
    print(r.count)
} else {
    print(codable: r)
}

