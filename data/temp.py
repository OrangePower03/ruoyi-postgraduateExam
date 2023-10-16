class Major:
    majorCode: str
    majorName: str
    majorType: str

    def __init__(self, majorCode: str, majorName: str, majorType: str) -> None:
        self.majorName = majorName
        self.majorCode = majorCode
        self.majorType = majorType


path = 'resources/major.txt'
file = open(path, 'r', encoding='GBK')


def initData() -> Major or None:
    line = file.readline()
    s: [str] = line.split(",")
    if len(s) == 1:
        return None
    return Major(s[0], s[1], s[2])


if __name__ == '__main__':
    with open('resources/temp/majorDatabase.txt', 'w', encoding='GBK') as f:
        i = 1
        while True:
            m: Major = initData()
            if m is None:
                break
            if m.majorCode != 'NULL':
                f.write(f"{i},{m.majorName}\n")
                i += 1
    file.close()
