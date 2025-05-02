//
//  WatchSportType.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 25/05/23.
//  Copyright © 2023 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

//MARK: - SPORT CATEGORIES
public enum SportCategory: String, CaseIterable {
    case basic
    case ball
    case workout
    case leisure
    case ice
    case water
    case extreme

    public var title: String {
        switch self {
        case .basic: return .localized(.basicSports)
        case .ball: return .localized(.ballSports)
        case .workout: return .localized(.workoutTraining)
        case .leisure: return .localized(.leisureSports)
        case .ice: return .localized(.iceSports)
        case .water: return .localized(.waterSports)
        case .extreme: return .localized(.extremeSports)
        }
    }

    /// Returns all WatchSportMode cases associated with this category.
    var allSports: [WatchSportMode] {
        WatchSportMode.allCases.filter { $0.category == self }
    }
    
    /// All valid cases based on watch type.
    /// This is the default order of the Menu Items.
    public static func validCategories(for watchType: SmartWatchType) -> [SportCategory] {
        switch watchType {
        case .v3:
            return [.basic, .ball, .workout, .leisure, .ice, .water, .extreme]
        default: return [.basic, .ball, .workout, .leisure, .ice, .water, .extreme]
        }
    }
    
    /// Returns all WatchSportMode cases associated with this category and the given watch type.
    func allSports(for watchType: SmartWatchType) -> [WatchSportMode] {
        WatchSportMode.validItems(for: watchType).filter { $0.category == self }
    }
}

//MARK: - SPORT TYPES
///https://idoosmart.github.io/IDOGitBook/en/IDOSportTypes.html
///https://idoosmart.github.io/IDOGitBook/en/set/IDOSetSportSortFunction.html?h=setSportModeSortCommand
public enum WatchSportMode: Int, CaseIterable, Hashable, Identifiable, Codable {
    public var id: Int { rawValue }
    
    // Null sport type
    case null = 0
    // Walking
    case walk = 1
    // Running
    case run = 2
    // Cycling
    case cycling = 3
    // On foot, Hiking
    case onFoot = 4
    // Swimming
    case swim = 5
    // Climbing
    case climb = 6
    // Badminton
    case badminton = 7
    // Other sports
    case other = 8
    // Fitness
    case fitness = 9
    // Dynamic
    case dynamic = 10
    // Elliposid
    case elliposid = 11
    // Treadmill
    case treadmill = 12
    // Sit-ups
    case sitUp = 13
    // Push-ups
    case pushUp = 14
    // Dumbbells
    case dumbbells = 15
    // Weightlifting
    case lifting = 16
    // Aerobics
    case aerobics = 17
    // Yoga
    case yoga = 18
    // Skipping rope
    case rope = 19
    // Ping Pong
    case pingPong = 20
    // basketBall
    case basketBall = 21
    // Soccer
    case soccer = 22
    // Volleyball
    case volleyball = 23
    // Tennis
    case tennisBall = 24
    // Golf
    case golf = 25
    // Baseball
    case baseball = 26
    // Skiing
    case ski = 27
    // Roller skating
    case roller = 28
    // Dancing
    case dancing = 29
    // Roller machine
    case rollerMachine = 31
    // Pilates
    case pilates = 32
    // Cross training
    case crossTrain = 33
    // Cardio
    case cardio = 34
    // Zumba
    case zumba = 35
    // Square dance
    case squareDance = 36
    // Plank
    case plank = 37
    // Gym
    case gym = 38
    // Oxygen aerobics
    case aerobicsOxygen = 39
    // Outdoor running
    case outdoorRun = 48
    // Indoor running
    case indoorRun = 49
    // Outdoor Biking
    case outdoorBiking = 50
    // Indoor cycling
    case indoorCycle = 51
    // Outdoor walking / Outdoor Hiking
    case outdoorWalk = 52
    // Indoor walking
    case indoorWalk = 53
    // Pool swimming
    case poolSwim = 54
    // Open water swimming
    case waterSwim = 55
    // Elliptical machine
    case ellipticalMachine = 56
    // Rowing machine
    case rower = 57
    // High-intensity interval training
    case hiit = 58
    // Cricket
    case cricket = 75
    // Free training
    case freeTraining = 100
    // Functional strength training
    case functionalStrengthTraining = 101
    // Core training
    case coreTraining = 102
    // Stepper
    case stepper = 103
    // Relaxation and stretching
    case organizeAndRelax = 104
    // Traditional strength training
    case traditionalStrengthTraining = 110
    // Pull-up
    case pullUp = 112
    // Opening and closing jumps
    case openingAndClosingJump = 114
    // Squats
    case squat = 115
    // High leg lifts
    case highLegLift = 116
    // Boxing
    case boxing = 117
    // Barbell exercises
    case barbell = 118
    // Martial arts
    case martialArts = 119
    // Tai Chi
    case taiChi = 120
    // Taekwondo
    case taekwondo = 121
    // Karate
    case karate = 122
    // Free fighting
    case freeFight = 123
    // Fencing
    case fencing = 124
    // Archery
    case archery = 125
    // Artistic gymnastics
    case artisticGymnastics = 126
    // Horizontal bar
    case horizontalBar = 127
    // Parallel bars
    case parallelBars = 128
    // Walking machine
    case walkingMachine = 129
    // Mountaineering machine
    case mountaineeringMachine = 130
    // Bowling
    case bowling = 131
    // Billiards
    case billiards = 132
    // Hockey
    case hockey = 133
    // Rugby
    case rugby = 134
    // Squash
    case squash = 135
    // Softball
    case softball = 136
    // Handball
    case handball = 137
    // Shuttlecock
    case shuttlecock = 138
    // Beach soccer
    case beachSoccer = 139
    // Sepaktakraw
    case sepaktakraw = 140
    // Dodgeball
    case dodgeball = 141
    // Hip hop
    case hipHop = 152
    // Ballet
    case ballet = 153
    // Social dance
    case socialDance = 154
    // Frisbee
    case frisbee = 155
    // Darts
    case darts = 156
    // Horseback riding
    case riding = 157
    // Building climbing
    case climbBuilding = 158
    // Kite flying
    case kiteFlying = 159
    // Fishing
    case goFishing = 160
    // Sledding
    case sled = 161
    // Snowmobiling
    case snowmobile = 162
    // Snowboarding
    case snowboarding = 163
    // Winter sports
    case snowSports = 164
    // Alpine skiing
    case alpineSkiing = 165
    // Cross-country skiing
    case crossCountrySkiing = 166
    // Curling
    case curling = 167
    // Ice hockey
    case iceHockey = 168
    // Winter biathlon
    case winterBiathlon = 169
    // Surfing
    case surfing = 170
    // Sailing
    case sailboat = 171
    // Windsurfing
    case sailboard = 172
    // Kayaking
    case kayak = 173
    // Motorboating
    case motorboat = 174
    // Rowing boat
    case rowboat = 175
    // Rowing
    case rowing = 176
    // Dragon boat
    case dragonBoat = 177
    // Water polo
    case waterPolo = 178
    // Drift
    case drift = 179
    case skate = 180
    case rockClimbing = 181
    case bungeeJumping = 182
    case parkour = 183
    case bmx = 184
    case footvolley = 187
    case standWaterSkiing = 188
    case crossCountryRun = 189
    case rolledAbdomen = 190
    case bobbyJump = 191
    case kabaddi = 192
    case outdoorFun = 193
    case otherActivity = 194
    
    /// All valid cases based on watch type.
    /// This is the default order of the Menu Items.
    public static func validItems(for watchType: SmartWatchType) -> [WatchSportMode] {
        switch watchType {
        case .v3:
            return [
                ///#BASIC
                .outdoorWalk, .indoorWalk, .poolSwim, .waterSwim, .outdoorBiking, .rower, .yoga, .outdoorRun,
                .dancing, .functionalStrengthTraining, .hiit, .coreTraining,
                .organizeAndRelax, .stepper, .indoorRun, .ellipticalMachine, .onFoot, .cricket, .indoorCycle,
                
                ///#BALL
                .tennisBall, .bowling, .pingPong, .golf, .basketBall, .soccer, .badminton, .baseball, .billiards, .hockey, .rugby, .squash,
                .softball, .handball, .shuttlecock, .beachSoccer, .sepaktakraw, .dodgeball,
                
                ///#WORKOUT
                .pilates, .fitness, .traditionalStrengthTraining, .aerobics, .sitUp, .plank, .openingAndClosingJump, .pullUp,
                .squat, .pushUp, .highLegLift, .barbell, .dumbbells, .boxing, .martialArts, .taiChi, .taekwondo, .karate, .freeFight,
                .fencing, .archery, .artisticGymnastics, .horizontalBar, .parallelBars, .cardio, .mountaineeringMachine,
                
                ///#LEISURE
                .ballet, .squareDance, .hipHop, .socialDance, .climb, .rope,
                .frisbee, .darts, .riding, .climbBuilding, .kiteFlying, .goFishing,
                
                ///#ICE
                .sled, .snowmobile, .ski, .snowboarding, .alpineSkiing, .crossCountrySkiing, .snowSports, .curling, .iceHockey, .winterBiathlon,
                
                ///#WATER
                .surfing, .sailboat, .sailboard, .kayak, .rowboat, .rowing, .motorboat, .dragonBoat, .waterPolo, .drift,
                
                ///#EXTREME
                .bungeeJumping, .skate, .rockClimbing, .parkour, .bmx
            ]
        default:
            return [
                .outdoorWalk, .indoorWalk, .outdoorBiking, .indoorCycle, .outdoorRun, .indoorRun,
                .onFoot, .cricket, .soccer, .hockey, .rugby, .pilates, .fitness, .poolSwim,
                .tennisBall, .pingPong, .basketBall, .yoga
            ]
        }
    }
    
    public var title: String {
        switch self {
        case .null: return String.localized(.empty_text)
        case .walk: return String.localized(.walk)
        case .run: return String.localized(.run)
        case .cycling: return String.localized(.cycling)
        case .onFoot: return String.localized(.hiking)
        case .swim: return String.localized(.swim)
        case .climb: return String.localized(.climb)
        case .badminton: return String.localized(.badminton)
        case .other: return String.localized(.other)
        case .fitness: return String.localized(.fitness)
        case .dynamic: return String.localized(.empty_text)
        case .elliposid: return String.localized(.elliposid)
        case .treadmill: return String.localized(.treadmill)
        case .sitUp: return String.localized(.sitUp)
        case .pushUp: return String.localized(.pushUp)
        case .dumbbells: return String.localized(.dumbbells)
        case .lifting: return String.localized(.lifting)
        case .aerobics: return String.localized(.aerobics)
        case .yoga: return String.localized(.yoga)
        case .rope: return String.localized(.rope)
        case .pingPong: return String.localized(.pingPong)
        case .basketBall: return String.localized(.basketBall)
        case .soccer: return String.localized(.soccer)
        case .volleyball: return String.localized(.volleyball)
        case .tennisBall: return String.localized(.tennisBall)
        case .golf: return String.localized(.golf)
        case .baseball: return String.localized(.baseball)
        case .ski: return String.localized(.skating)
        case .roller: return String.localized(.roller)
        case .dancing: return String.localized(.dancing)
        case .rollerMachine: return String.localized(.rollerMachine)
        case .pilates: return String.localized(.pilates)
        case .crossTrain: return String.localized(.crossTrain)
        case .cardio: return String.localized(.cardioCruiser)
        case .zumba: return String.localized(.zumba)
        case .squareDance: return String.localized(.squareDance)
        case .plank: return String.localized(.plank)
        case .gym: return String.localized(.gym)
        case .aerobicsOxygen: return String.localized(.aerobicsOxygen)
        case .outdoorRun: return String.localized(.outdoorRun)
        case .indoorRun: return String.localized(.indoorRun)
        case .outdoorBiking: return String.localized(.outdoorBiking)
        case .indoorCycle: return String.localized(.indoorCycle)
        case .outdoorWalk: return String.localized(.outdoorWalk)
        case .indoorWalk: return String.localized(.indoorWalk)
        case .poolSwim: return String.localized(.poolSwim)
        case .waterSwim: return String.localized(.waterSwim)
        case .ellipticalMachine: return String.localized(.ellipticalMachine)
        case .rower: return String.localized(.rower)
        case .hiit: return String.localized(.hiit)
        case .cricket: return String.localized(.cricket)
        case .freeTraining: return String.localized(.freeTraining)
        case .functionalStrengthTraining: return String.localized(.functionalStrengthTraining)
        case .coreTraining: return String.localized(.coreTraining)
        case .stepper: return String.localized(.stepper)
        case .organizeAndRelax: return String.localized(.organizeAndRelax)
        case .traditionalStrengthTraining: return String.localized(.traditionalStrengthTraining)
        case .pullUp: return String.localized(.pullUp)
        case .openingAndClosingJump: return String.localized(.openingAndClosingJump)
        case .squat: return String.localized(.squat)
        case .highLegLift: return String.localized(.highKneeLift)
        case .boxing: return String.localized(.boxing)
        case .barbell: return String.localized(.barbell)
        case .martialArts: return String.localized(.martialArts)
        case .taiChi: return String.localized(.taiChi)
        case .taekwondo: return String.localized(.taekwondo)
        case .karate: return String.localized(.karate)
        case .freeFight: return String.localized(.freeFight)
        case .fencing: return String.localized(.fencing)
        case .archery: return String.localized(.archery)
        case .artisticGymnastics: return String.localized(.artisticGymnastics)
        case .horizontalBar: return String.localized(.horizontalBar)
        case .parallelBars: return String.localized(.parallelBars)
        case .walkingMachine: return String.localized(.walkingMachine)
        case .mountaineeringMachine: return String.localized(.mountaineeringMachine)
        case .bowling: return String.localized(.bowling)
        case .billiards: return String.localized(.billiards)
        case .hockey: return String.localized(.hockey)
        case .rugby: return String.localized(.americanFootball)
        case .squash: return String.localized(.squash)
        case .softball: return String.localized(.softball)
        case .handball: return String.localized(.handball)
        case .shuttlecock: return String.localized(.shuttlecockKicking)
        case .beachSoccer: return String.localized(.beachSoccer)
        case .sepaktakraw: return String.localized(.sepaktakraw)
        case .dodgeball: return String.localized(.dodgeBall)
        case .hipHop: return String.localized(.hipHop)
        case .ballet: return String.localized(.ballet)
        case .socialDance: return String.localized(.socialDance)
        case .frisbee: return String.localized(.frisbee)
        case .darts: return String.localized(.darts)
        case .riding: return String.localized(.riding)
        case .climbBuilding: return String.localized(.climbBuilding)
        case .kiteFlying: return String.localized(.kiteFlying)
        case .goFishing: return String.localized(.goFishing)
        case .sled: return String.localized(.sled)
        case .snowmobile: return String.localized(.bobsleigh)
        case .snowboarding: return String.localized(.snowboarding)
        case .snowSports: return String.localized(.snowSports)
        case .alpineSkiing: return String.localized(.alpineSkiing)
        case .crossCountrySkiing: return String.localized(.crossCountrySkiing)
        case .curling: return String.localized(.curling)
        case .iceHockey: return String.localized(.iceHockey)
        case .winterBiathlon: return String.localized(.biathlon)
        case .surfing: return String.localized(.surfing)
        case .sailboat: return String.localized(.sailboat)
        case .sailboard: return String.localized(.sailboard)
        case .kayak: return String.localized(.kayak)
        case .motorboat: return String.localized(.motorboat)
        case .rowboat: return String.localized(.paddling)
        case .rowing: return String.localized(.rowing)
        case .dragonBoat: return String.localized(.dragonBoat)
        case .waterPolo: return String.localized(.waterPolo)
        case .drift: return String.localized(.rafting)
        case .skate: return String.localized(.skateBoarding)
        case .rockClimbing: return String.localized(.rockClimbing)
        case .bungeeJumping: return String.localized(.bungeeJumping)
        case .parkour: return String.localized(.parkour)
        case .bmx: return String.localized(.bmx)
        case .footvolley: return String.localized(.footvolley)
        case .standWaterSkiing: return String.localized(.standWaterSkiing)
        case .crossCountryRun: return String.localized(.crossCountryRun)
        case .rolledAbdomen: return String.localized(.rolledAbdomen)
        case .bobbyJump: return String.localized(.bobbyJump)
        case .kabaddi: return String.localized(.kabaddi)
        case .outdoorFun: return String.localized(.outdoorFun)
        case .otherActivity: return String.localized(.otherActivity)
        }
    }
}

//MARK: - GET CATEGORY
public extension WatchSportMode {
    ///Get category based on Sport Activity.
    var category: SportCategory {
        switch self {
            // .basic
        case .outdoorWalk, .indoorWalk, .poolSwim, .waterSwim, .outdoorBiking, .rower, .yoga, .outdoorRun,
                .dancing, .functionalStrengthTraining, .hiit, .coreTraining,
                .organizeAndRelax, .stepper, .indoorRun, .ellipticalMachine, .onFoot, .cricket, .indoorCycle:
            return .basic
            // .ball
        case .tennisBall, .bowling, .pingPong, .golf, .basketBall, .soccer, .badminton, .baseball, .billiards, .hockey, .rugby, .squash,
                .softball, .handball, .shuttlecock, .beachSoccer, .sepaktakraw, .dodgeball:
            return .ball
            // .workout
        case .pilates, .fitness, .traditionalStrengthTraining, .aerobics, .sitUp, .plank, .openingAndClosingJump, .pullUp,
                .squat, .pushUp, .highLegLift, .barbell, .dumbbells, .boxing, .martialArts, .taiChi, .taekwondo, .karate, .freeFight,
                .fencing, .archery, .artisticGymnastics, .horizontalBar, .parallelBars, .cardio, .mountaineeringMachine:
            return .workout
            // .leisure
        case .ballet, .squareDance, .hipHop, .socialDance, .climb, .rope,
                .frisbee, .darts, .riding, .climbBuilding, .kiteFlying, .goFishing:
            return .leisure
            // .ice
        case .sled, .snowmobile, .ski, .snowboarding, .alpineSkiing, .crossCountrySkiing, .snowSports, .curling, .iceHockey, .winterBiathlon:
            return .ice
            // .water
        case .surfing, .sailboat, .sailboard, .kayak, .rowboat, .rowing, .motorboat, .dragonBoat, .waterPolo, .drift:
            return .water
            // .extreme
        case .bungeeJumping, .skate, .rockClimbing, .parkour, .bmx:
            return .extreme
        default:
            return .basic
        }
    }
}

public extension WatchSportMode {
    var iconName: String {
        switch self {
        case .aerobics: return "aerobics"
        case .alpineSkiing: return "alpineSkiing"
        case .archery: return "archery"
        case .badminton: return "badminton"
        case .ballet: return "ballet"
        case .baseball: return "baseball"
        case .basketBall: return "basketBall"
        case .beachSoccer: return "beachSoccer"
        case .billiards: return "billiards"
        case .bmx: return "bmx"
        case .sled: return "sledding"
        case .bowling: return "bowling"
        case .boxing: return "boxing"
        case .martialArts: return "martialArt"
        case .bungeeJumping: return "bungeeJumping"
        case .cardio: return "cardioCrusier"
        case .climb: return "climb"
        case .mountaineeringMachine: return "climbingMachine"
        case .organizeAndRelax: return "coolDown"
        case .coreTraining: return "coreTraining"
        case .cricket: return "cricket"
        case .crossCountrySkiing: return "crossCountrySkiing"
        case .curling: return "curling"
        case .darts: return "darts"
        case .dodgeball: return "dodgeBall"
        case .dragonBoat: return "dragonBoatRacing"
        case .dumbbells: return "dumbBell"
        case .ellipticalMachine: return "elliptical"
        case .fencing: return "fencing"
        case .goFishing: return "fishing"
        case .freeFight: return "freeSparing"
        case .frisbee: return "frisbee"
        case .functionalStrengthTraining: return "functionalTraining"
        case .golf: return "golf"
        case .socialDance: return "groupDance"
        case .artisticGymnastics: return "gymnastics"
        case .barbell: return "workout"
        case .handball: return "handBall"
        case .shuttlecock: return "badminton"
        case .highLegLift: return "highKneeLift"
        case .hiit: return "hiit"
        case .onFoot: return "hiking"
        case .hockey: return "hockey"
        case .horizontalBar: return "horizontalBars"
        case .riding: return "horseRiding"
        case .iceHockey: return "iceHockey"
        case .indoorCycle: return "indoorCycle"
        case .indoorRun: return "indoorRun"
        case .indoorWalk: return "indoorWalk"
        case .kayak: return "kayaking"
        case .kiteFlying: return "kiteFlying"
        case .motorboat: return "motorBoating"
        case .waterSwim: return "openWaterSwim"
        case .outdoorBiking: return "outdoorCycle"
        case .outdoorRun: return "outdoorRun"
        case .outdoorWalk: return "outdoorWalk"
        case .parallelBars: return "parallelBars"
        case .parkour: return "parkour"
        case .pilates: return "pilates"
        case .plank: return "plank"
        case .poolSwim: return "poolSwim"
        case .pullUp: return "pullUps"
        case .rockClimbing: return "rockClimbing"
        case .rope: return "ropeSkipping"
        case .rowing: return "rowing"
        case .rugby: return "rugby"
        case .softball: return "saftBall"
        case .sailboat: return "sailBoating"
        case .sepaktakraw: return "sepakTakraw"
        case .sitUp: return "sitUps"
        case .skate: return "skateBoarding"
        case .snowboarding: return "snowBoarding"
        case .snowSports: return "snowSports"
        case .soccer: return "soccer"
        case .squareDance: return "squareDance"
        case .squash: return "squash"
        case .squat: return "squats"
        case .taiChi: return "taiChi"
        case .pushUp: return "pushUp"
        case .stepper: return "stepper"
        case .climbBuilding: return "stairClimbing"
        case .surfing: return "surfing"
        case .pingPong: return "tableTennis"
        case .taekwondo: return "taekwondo"
        case .karate: return "traditionalTraining"
        case .tennisBall: return "tennis"
        case .traditionalStrengthTraining: return "traditionalTraining"
        case .waterPolo: return "waterPolo"
        case .sailboard: return "windSurfing"
        case .fitness: return "workout"
        case .yoga: return "yoga"
        case .hipHop: return "streetDance"
        case .winterBiathlon: return "biathlon"
        case .rowboat: return "paddling"
        case .rower: return "rowing"
        case .dancing: return "dance"
        case .ski: return "skating"
        case .drift: return "rafting"
        case .openingAndClosingJump: return "jumpingJacks"
        case .snowmobile: return "bobsleigh"
        
        default:
            return "other"
        }
    }
}

//public extension WatchSportMode {
//    /**
//     Returns the IDO_SPORT_TYPE value corresponding to the WatchSportActivityType instance.
//     Returns: The IDO_SPORT_TYPE value representing the sport activity type.
//     */
//    public var idoSportType: IDO_SPORT_TYPE {
//        return IDO_SPORT_TYPE(rawValue:self.rawValue) ?? .NULL
//    }
//}
//
///**
// Extension on IDO_SPORT_TYPE to provide a computed property sportActivityType that returns the corresponding WatchSportActivityType value.
// If the conversion fails, it returns .null.
// */
//extension IDO_SPORT_TYPE {
//    public var sportActivityType: WatchSportActivityType {
//        return WatchSportActivityType(rawValue:self.rawValue) ?? .null
//    }
//}


