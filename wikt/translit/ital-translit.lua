-- This module will transliterate text in the Old Italic script. 
-- It is used to transliterate Etruscan (ett), Old Latin (itc-ola), North Picene (nrp), 
-- Oscan (osc), South Picene (spx), Camunic (xcc), Faliscan (xfa), Lemnian (xle), 
-- Lepontic (xlp), Raetic (xrr), Umbrian (xum) and Venetic (xve).

local export = {}

-- Standard transcription
local common_rules = {
	['𐌀'] = 'a',
	['𐌁'] = 'b',
	['𐌂'] = 'c',
	['𐌃'] = 'd',
	['𐌄'] = 'e',
	['𐌅'] = 'v',
	['𐌆'] = 'z',
	['𐌇'] = 'h',
	['𐌈'] = 'θ',
	['𐌉'] = 'i',
	['𐌊'] = 'k',
	['𐌋'] = 'l',
	['𐌌'] = 'm',
	['𐌍'] = 'n',
	['𐌎'] = 'š',
	['𐌏'] = 'o',
	['𐌐'] = 'p',
	['𐌑'] = 'ś',
	['𐌒'] = 'q',
	['𐌓'] = 'r',
	['𐌔'] = 's',
	['𐌕'] = 't',
	['𐌖'] = 'u',
	['𐌗'] = 'x',
	['𐌘'] = 'φ',
	['𐌙'] = 'χ',
	['𐌚'] = 'f',
	['𐌛'] = 'ř',
	['𐌜'] = 'ç',
	['𐌝'] = 'í',
	['𐌞'] = 'ú',
	['𐌟'] = 'k',
	-- Numerals
	['𐌠'] = 'Ⅰ',
	['𐌡'] = 'Ⅴ',
	['𐌢'] = 'Ⅹ',
	['𐌣'] = 'Ⅼ',
	-- Punctuation
	['·'] = ' ',
	['⁚'] = ' ',
	['⁝'] = ' ',
}

local lang_rules = {
	['ett'] = {		-- Etruscan
		['𐌟'] = 'Ⅽ',
	};

	['itc-ola'] = {		-- Old Latin
		['𐌅'] = 'f',
	};

	['nrc'] = {		-- Noric
		['𐌂'] = 'g',
		['𐌈'] = 'd',
		['𐌙'] = 'g',
	};
	
	['nrp'] = {		-- North Picene
		['𐌂'] = 'g',
	};

	['osc'] = {		-- Oscan
		['𐌂'] = 'g',
	};

	['spx'] = {		-- South Picene
		['𐌂'] = 'g',
		['𐌑'] = 'í',
		['·'] = 'o',
		['⁚'] = 'f',
	};
	
	['xcc'] = {		-- Camunic
		['𐌁'] = 'ś',
		['𐌂'] = 'g',
		['𐌑'] = 'b',
		['𐌙'] = 's',
		['𐌟'] = 'þþ',
		['𐌣'] = 'þ',
	};
	
	['xrr'] = {		-- Raetic
		['𐌁'] = 'þ',
		['𐌂'] = '?',
	};
	
	['xum'] = {		-- Umbrian
		['𐌈'] = 't',
	};
	
	['xve'] = {		-- Venetic
		['𐌂'] = 'j',
		['𐌆'] = 'd',
		['𐌇𐌅'] = 'f',
		['𐌘'] = 'b',
		['𐌙'] = 'g',
	};
}

function export.tr(text, lang, sc)
	-- If the script is not Ital, do not transliterate
	if sc ~= "Ital" then
		return
	end
	
	-- Transliterate language-specific exceptions
	if lang == "xve" then
		text = mw.ustring.gsub(text, '𐌇𐌅', 'f')
	end
	
	if lang_rules[lang] then
		text = mw.ustring.gsub(text, '.', lang_rules[lang])
	end
	
	-- Transliterate remaining characters
	text = mw.ustring.gsub(text, '.', common_rules)
	
	return text
end

return export

-- Text	Expected	Actual
-- Passed	South Picene: 𐌌𐌄⁚𐌉𐌑𐌍	mefiín	mefiín
-- -- Unit tests for [[Module:Ital-translit]]. Refresh page to run tests.
-- local tests = require('Module:UnitTests')
-- local module = require('Module:Ital-translit')
-- local m_lang = require('Module:languages')

-- function tests:check_translit(lang, text, translit)
-- 	local langname = m_lang.getByCode(lang):getCanonicalName()
-- 	self:equals(langname .. ': <span class="Ital" lang="' .. lang .. '">[[' .. text .. '#' .. langname .. '|' .. text .. ']]</span>', module.tr(text, lang, 'Ital'), translit)
-- end

-- function tests:test_translits()
-- 	self:check_translit('spx', '𐌌𐌄⁚𐌉𐌑𐌍', 'mefiín')
-- end

-- return tests