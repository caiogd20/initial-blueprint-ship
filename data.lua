-- data.lua

-- Este script é carregado uma vez, no início do jogo, quando o mundo é criado.

-- A função on_player_created é chamada quando um novo jogador entra no jogo
-- ou quando um novo jogo é iniciado.
script.on_event(defines.events.on_player_created, function(event)
    local player = game.get_player(event.player_index)

    -- Verifica se o jogador existe e se está no modo normal (não espectador, etc.)
    if player and player.character and player.character.valid then
        -- Remove o personagem atual (que inclui a nave inicial se for o padrão)
        player.character.destroy()

        -- Obtém a superfície onde o jogador está
        local surface = player.surface

        -- Obtém a posição da nave inicial antes de ser destruída
        -- (Isso pode ser um pouco complicado, pois a nave já foi destruída.
        -- Uma abordagem mais robusta seria pegar a posição do jogador.)
        local player_position = player.position

        -- Cria uma fornalha de pedra na posição inicial do jogador
        -- Certifique-se de que o nome da entidade 'stone-furnace' está correto.
        local furnace = surface.create_entity({
            name = "stone-furnace",
            position = player_position,
            force = player.force -- Atribui a fornalha à força do jogador
        })

        -- Se você quiser, pode dar alguns itens básicos ao jogador aqui,
        -- já que ele não terá o inventário inicial da nave.
        player.insert({name = "wood", count = 50})
        player.insert({name = "stone", count = 50})
        player.insert({name = "iron-plate", count = 10})
        player.insert({name = "copper-plate", count = 10})

        -- Log para o console do jogo (opcional, útil para depuração)
        game.print("A nave inicial foi substituída por uma fornalha de pedra para o jogador " .. player.name .. "!")
    end
end)

-- Nota: Para um comportamento mais consistente e evitar problemas com
-- a nave inicial sendo criada e então destruída, uma abordagem mais avançada
-- poderia envolver a modificação do protótipo de início do jogo ou a
-- redefinição do inventário inicial, mas para um mod simples de substituição
-- como este, destruir o personagem e criar a fornalha funciona.