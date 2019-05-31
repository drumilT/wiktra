-- This module will transliterate Kumyk language text per WT:KUM TR.

local export = {}

local tt = {
	['т']='t',['Т']='T', ['р']='r',['Р']='R',   ['ф']='f',['Ф']='F', 
	['ю']='yu',['Ю']='Yu', ['ш']='š',['Ш']='Š', ['ь']='ʹ',['Ь']='ʹ',   ['ъ']='ʺ',['Ъ']='ʺ', ['н']='n',['Н']='N', 
	['п']='p',['П']='P',   ['й']='y',['Й']='Y', ['л']='l',['Л']='L',   ['з']='z',['З']='Z', ['е']='e',['Е']='E', 
	['г']='g',['Г']='G',   ['б']='b',['Б']='B', ['у']='u',['У']='U',   ['с']='s',['С']='S', ['х']='h',['Х']='H',
	['ч']='č',['Ч']='Č', ['щ']='šč',['Щ']='Šč', ['я']='ya',['Я']='Ya', ['ы']='ı',['Ы']='I', ['э']='e',['Э']='E', 
	['м']='m',['М']='M',   ['о']='o',['О']='O', ['и']='i',['И']='I', ['ё']='yo',['Ё']='Yo', ['ж']='j',['Ж']='J',
	['к']='k',['К']='K',   ['д']='d',['Д']='D', ['в']='v',['В']='V', ['ц']='ts',['Ц']='Ts', ['а']='a',['А']='A'
};
local mapping = { ['гь']= 'h' , ['Гь']= 'H', ['гъ']='ğ' ,['Гъ']='Ğ' , ['уь']='ü',['Уь']='Ü',
                  ['къ']='q',   ['Къ']='Q' , ['нг']='ñ',['Нг']='Ñ' , ['оь']='ö',['Оь']='Ö'

}
function export.tr(text, lang, sc)
	for digraph, replacement in pairs(mapping) do
		text = mw.ustring.gsub(text, digraph, replacement)
	end
	
	text = mw.ustring.gsub(
		text,
		'([АОӨӘУЫЕЯЁЮИЕаоөәуыэяёюиеъь%A][́̀]?)([Ее])',
		function(a, e)
			return a .. ( e == 'е' and 'ye' or 'Ye' )
		end
	)
		:gsub('^Е','Ye')
		:gsub('^е','ye');
	
	return (mw.ustring.gsub(text, '.', tt))
end

return export