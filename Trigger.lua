local Trigger = class('Trigger')

function Trigger:initialize(pworld, x, y, w, h, trigger)
    self.id = "trigger"
    self.pworld = pworld
    self.pworld:add(self, x, y, w, h)
    self.trigger = trigger
end

return Trigger
