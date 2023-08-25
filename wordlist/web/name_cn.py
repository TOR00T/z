import os
from pypinyin import lazy_pinyin

file_path = "name.txt"

if not os.path.exists(file_path):
    print(f"{file_path} Not Found")
    exit()

with open(file_path, mode="r", encoding="utf-8") as f:
    for line in f:
        pinyin_list = lazy_pinyin(line.strip())
        abbreviation = "".join([p[0] for p in pinyin_list])
        print(abbreviation)
        if len(pinyin_list) == 3:
            harff_pinyin = pinyin_list[0] + pinyin_list[1][0] + pinyin_list[2][0]
            print(harff_pinyin)

            harf_pinyin = "".join(pinyin_list[:2]) + pinyin_list[2][0]
            print(harf_pinyin)

        elif len(pinyin_list) == 2:
            harft_pinyin = "".join(pinyin_list[:1]) + pinyin_list[1][0]
            print(harft_pinyin)
        
        full_pinyin = "".join(pinyin_list)
        print(full_pinyin)