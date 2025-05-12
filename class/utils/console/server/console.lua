local IS_SERVER = IsDuplicityVersion()

Logger = {}

function Logger:Trace(string, style)
    local styles = { info = '^4[loadCore] > [INFO]^0', warn = '^8[loadCore] > [WARN]^0', done = '^2[loadCore] > [SUCCESS]^0', err = '^1[loadCore] > [ERROR]^0' }
    local date

    if IS_SERVER then
        date = string.format('%02d/%02d/%04d %02d:%02d:%02d', os.date('%d'), os.date('%m'), os.date('%Y'), os.date('%H'), os.date('%M'), os.date('%S'))
    else
        local year, month, day, hour, minute, second = GetUtcTime()
        date = string.format('%02d/%02d/%04d %02d:%02d:%02d', day, month, year, hour, minute, second)
    end
    
    print(string.format('%s - ^5(%s)^0 ^2 > ^0%s', styles[style] or styles.info, date, string))
end