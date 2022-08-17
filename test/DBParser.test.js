import { expect, it, describe } from 'vitest'
import * as DBParser from '../src/lib/DBParser.mjs'

describe('DB Parser', () => {
  it('modifiedTone', async () => { 
    expect(DBParser.modifiedTone("1", "RisingTone")).toBe("#1");
    expect(DBParser.modifiedTone("123", "RisingTone")).toBe("#1#24");
    expect(DBParser.modifiedTone("(7)12", "RisingTone")).toBe("1#1#2");
    expect(DBParser.modifiedTone("7[12]", "RisingTone")).toBe("[1#1#2]");
    expect(DBParser.modifiedTone("【1】7（12）", "RisingTone")).toBe("[#11](#1#2)");
    expect(DBParser.modifiedTone("#1#24", "FallingTone")).toBe("123");
    expect(DBParser.modifiedTone("1#1#2", "FallingTone")).toBe("(7)12");
    expect(DBParser.modifiedTone("[1#1#2]", "FallingTone")).toBe("7[12]");
  })
})