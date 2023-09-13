--[[
    Global Types Definitions
    Author: Kamran / portodemesso
--]]

export type HitData = {
    { Character: Model, Humanoid: Humanoid }
}

export type PowerClient = {
    tool: Tool,
    path: string,
    config: { },
    
    new: (tool: Tool) -> (PowerClient),
    addAnimation: (self: PowerClient, name: string, id: string) -> AnimationTrack,
    doCooldown: (self: PowerClient) -> boolean,
    getSound: (self: PowerClient, name: string) -> (Sound),
    sendToServer: (... any?) -> (),

    _toolName: string,
    _animations: { animationName: AnimationTrack },
    _soundCache: { soundName: Sound },
    _cooldown: number,
    _lastClock: number,
    _janitor: typeof({}),
}

export type PowerServer = {
    tool: Tool,
    path: string,
    owner: Player,
    config: { },

    doCooldown: (self: PowerServer) -> boolean,
    setEventListener: (self: PowerServer, onEvent: (... any?) -> ()) -> (),
    getSound: (self: PowerServer, name: string) -> (Sound),
    playEffectForOthers: (self: PowerServer, effect: string, ... any?) -> (),
    playEffect: (self: PowerServer, effect: string, ... any?) -> ()
}