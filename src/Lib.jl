"""
# module Lib

- Julia version: 
- Author: Анастасия
- Date: 2019-11-03

# Examples

```jldoctest
julia>
```
"""
module Lib
export id

function id(x)
  @info "Program running" x
  function users_decision() #количество строк на 1 странице; пользователь может установить его сам или оставить по умолчанию
     @info "Users_decision called" x
     println("По умолчанию на каждой странице размещается 45 строк. Если хотите изменить это значение, введите 1, иначе введите 0.")
     check = parse(Int, readline())
     @info "Check is:" check
        if(check==0)
           n= 0
        end
        if(check==1)
           println("Введите количество строк на одной странице")
           n = parse(Int, readline())
           @info "Lines on one page should be:" n
        end
     global page_limit = set_page_limit(check, n)
  end


  function set_page_limit(check,n)
      @info "Set_page_limit called"
      if(check==0)
          page_limit=45
      end
       if(check==1)
            page_limit = n
       end
       @info "Lines on one page:" page_limit
     return page_limit
  end


  function sort_dict() #считывание входных данных, вызов фуекций для их видоизменения, итоговая сортировка после всех изменений
      @info "Sort_dict called" x
      dict = Dict()
      counter = 0
      open("add/text.txt","r") do file
          @debug "File text.txt opened" x
          for string in eachline(file)
              counter = counter + 1
              words = line_change(string)
              dict = ignore_checking(dict, words, counter)
          end
          close(file)
          @debug "File text.txt closed" x
      end
      @info "Dictionary is:" dict
      return sort(collect(dict))
  end


  function line_change(string) #из каждой строки удаляем знаковые символы, не входящие в индекс, делаем все буквы строчными
      @info "Line_change called" x
      string = replace(string, r"[,.!@&#%~$*+?:;\'(){}–]" => "")
      string = lowercase(string)
      string = split(string)
      return string
  end


  function ignore_checking(dict, words, counter) #пропукаем междометия, предлоги и другие слова, также не входящие в индекс
      @info "Ignore_checking called" x
      ignore = readlines("add/unusable.txt")
      @debug "Unusable read" x
      for word in words
         if !(word in ignore)
            dict = word_processing(word, dict, counter)
         else
            @info "This word was ignored" word
         end
      end
      return dict
   end


  function word_processing(word, dict, counter) #обработка слов, которые войдут в индекс
      @info "Word_processing called" x
      page = trunc(Int64,counter/page_limit+1)
      if haskey(dict, word) #если слово уже есть в словаре, увеличиваем его частоту встречаемости
          dict[word][1]+=1
            if !(page in dict[word][2])#если слово,имеющееся в словаре, встречается на странице впервые, добавляем страницу в словарь
                 push!(dict[word][2], page)
            end
      else
         dict[word]=[1, [page]] #если слова в словаре еще нет, добавляем его в словарь вместе с номером текущей страницы
      end
      return dict
  end


   function out(s_dict, to_open)
       @info "Out called" x
       @info "Sorted_dictionary is: " s_dict
       @info "To_open is:" to_open
       if(to_open=="index")
          file = open("text_index.txt", "w")
          @debug "text_index.txt opened" x
       else
          file = open("top_words.txt", "w")
          @debug "top_words opened" x
       end
       for i in eachindex(s_dict)
           if(to_open == "top" && i==6)
               break
           end
           write(file, "$i. Слово '$(s_dict[i].first)'\n Количество: $(s_dict[i][2][1])\n Страницы: ")
                for k in s_dict[i][2][2]
                    write(file, "$k ")
                end
           write(file, "\n")
           write(file, "=====")
           write(file, "\n")
       end
       close(file)
       @debug "File for data writing closed" x
   end


   function make_index()
       @info "Make_index called" x
       index = sort_dict()
       @info "Index should be:" index
       to_open = "index"
       out(index, to_open)
       make_top(index)
   end


   function make_top(index)
       @info "Make_top called" x
       top = sort(collect(index), by = x->x[2], rev = true)
       @info "Top rating: " top
       to_open = "top"
       out(top, to_open)
   end
   users_decision()
   make_index()
   @info "End of the program" x
return x
end
end




