#include <amxmodx>
#include <amxmisc>

#define PLUGIN "Valorant Kill Sounds"
#define VERSION "1.0"
#define AUTHOR "Alazul"

#define MAX_KILLS 5

new g_iKills[MAX_PLAYERS + 1]

public plugin_init()
{
    register_plugin(PLUGIN, VERSION, AUTHOR)
    register_event("DeathMsg", "newkill", "a")
    register_event("HLTV", "round_start", "a", "1=0") 
}

public plugin_precache()
{
    // Ses dosyalarını önbelleğe al
    precache_sound("alazul/kill1.wav")
    precache_sound("alazul/kill2.wav")
    precache_sound("alazul/kill3.wav")
    precache_sound("alazul/kill4.wav")
    precache_sound("alazul/kill5.wav")
}

public newkill()
{
    new killer = read_data(1)
    new victim = read_data(2)

    // Geçerli oyuncu olup olmadığını kontrol et
    if (!is_user_connected(killer) || !is_user_connected(victim)) return

    if (killer == victim) return

    g_iKills[killer]++

    new soundfile[64]
    // Ses dosyası adını oluştur
    format(soundfile, charsmax(soundfile), "alazul/kill%d.wav", min(g_iKills[killer], MAX_KILLS))

    // Ses dosyasını oynat
    client_cmd(0, "spk %s", soundfile)
}

public round_start()
{
    // Her oyuncunun öldürme sayacını sıfırla
    for (new id = 1; id <= MAX_PLAYERS; id++)
    {
        g_iKills[id] = 0
    }
}

public client_disconnect(id)
{
    g_iKills[id] = 0
}
