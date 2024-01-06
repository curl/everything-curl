-- I recently used a Lua filter for this purpose. It worked quite well:

local identifiers = {}

function Block (b)
  if b.identifier then
    identifiers[b.identifier] = true
  end
end

function Inline (i)
  if i.identifier then
    identifiers[i.identifier] = true
  end
end

function Link (l)
  local anchor = l.target:match('^#(.*)')
  if anchor and not identifiers[anchor] then
    io.stderr:write("broken link: " .. anchor .. "\n")
  end
end

return {
  {Block = Block, Inline = Inline},
  {Link = Link}
}
