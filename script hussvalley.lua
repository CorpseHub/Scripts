local StarterGui = game:GetService("StarterGui")

StarterGui:SetCore("SendNotification", {
    Title = "script loading..",
    Text = "wait 8 seconds to load",
    Duration = 8,
    Button1 = "Got it"
})

task.wait(8)
StarterGui:SetCore("SendNotification", {
    Title = "❗",
    Text = "Enjoy",
    Duration = 8,
    Button1 = "Got it"
})

do 
    Players = game:GetService("Players");
    ReplicatedStorage = game:GetService("ReplicatedStorage");
    UserInputService = game:GetService("UserInputService");
    Workspace = game:GetService("Workspace");
    RunService = game:GetService("RunService");
    StarterGui = game:GetService("StarterGui")
    Lighting = game:GetService("Lighting")
    Mobile = UserInputService.TouchEnabled
    LocalPlayer = Players.LocalPlayer
    Mouse = LocalPlayer:GetMouse()
end;

getgenv().library = {
    directory = "boros_remastered",
    folders = {
        "/fonts",
        "/configs",
        "/assets"
    },
    priority = {},
    whitelist = {},
    flags = {},
    config_flags = {},
    connections = {},   
    notifications = {notifs = {}},
    current_open; 
}

local Images = {"ESP.png", "World.png", "Wrench.png", "Settings.png", "Node.png", "cursor.png", "Bullet.png", "Snapline.png", "Pistol.png", "folder.png", "UZI.png", "FieldOfView2.png", "Lock.png", "Aimlock.png", "Cash.png", "Wheatt.png", "Pickkaxe.png", "unlocked.png"}

for _, path in next, library.folders do 
    makefolder(library.directory .. path)
end

for Index, Value in Images do
    local Location = library.directory.."/assets/"..Value
    if not isfile(Location) then
        local ImageDiddyAhhBlud = game:HttpGet("https://raw.githubusercontent.com/KingVonOBlockJoyce/imagessynex/main/"..Value)
        repeat wait() until ImageDiddyAhhBlud ~= nil
        writefile(Location, ImageDiddyAhhBlud)
    end
end

GetImage = function(Name)
    local Location = library.directory.."/assets/"..Name
    if isfile(Location) then
        return getcustomasset(Location)
    end
end

local Fonts = {}; do
    local function RegisterFont(Name, Weight, Style, Asset)
        if isfile(library.directory.."/assets/"..Asset.Id) then
            delfile(library.directory.."/assets/"..Asset.Id)
        end

        writefile(library.directory.."/assets/"..Asset.Id, Asset.Font)

        local Data = {
            name = Name,
            faces = {
                {
                    Name = "Normal",
                    weight = Weight,
                    style = Style,
                    assetId = getcustomasset(library.directory.."/assets/"..Asset.Id),
                },
            },
        }

        writefile(library.directory.."/fonts/"..Name .. ".font", game:GetService("HttpService"):JSONEncode(Data))

        return getcustomasset(library.directory.."/fonts/"..Name .. ".font");
    end
    
    local Tahoma = RegisterFont("Tahoma", 400, "Normal", {
        Id = "Tahoma.ttf",
        Font = game:HttpGet("https://github.com/KingVonOBlockJoyce/OctoHook-UI/raw/refs/heads/main/fs-tahoma-8px%20(3).ttf"),
    })

    local Pixel = RegisterFont("Pixel", 400, "Normal", {
        Id = "Pixel.ttf",
        Font = game:HttpGet("https://github.com/KingVonOBlockJoyce/vaderpaste.luau/raw/refs/heads/main/Pixel.ttf"),
    })

    local Minecraftia = RegisterFont("Minecraftia", 400, "Normal", {
        Id = "Minecraftia.ttf",
        Font = game:HttpGet("https://github.com/i77lhm/storage/raw/refs/heads/main/fonts/Minecraftia-Regular.ttf"),
    }) 

    local Verdana = RegisterFont("Verdana", 400, "Normal", {
        Id = "Verdana.ttf",
        Font = game:HttpGet("https://github.com/i77lhm/storage/raw/refs/heads/main/fonts/Verdana-Font.ttf"),
    })

    Fonts["Plex"] = Font.new(Tahoma, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    Fonts["Pixel"] = Font.new(Pixel, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    Fonts["Minecraftia"] = Font.new(Minecraftia, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    Fonts["Verdana"] = Font.new(Verdana, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
end

if not Mobile then
    local uis = game:GetService("UserInputService")
    local players = game:GetService("Players")
    local ws = game:GetService("Workspace")
    local http_service = game:GetService("HttpService")
    local gui_service = game:GetService("GuiService")
    local run = game:GetService("RunService")
    local tween_service = game:GetService("TweenService")
    local core_gui = game:GetService("CoreGui")

    local vec2 = Vector2.new
    local vec3 = Vector3.new
    local dim2 = UDim2.new
    local dim = UDim.new 
    local rect = Rect.new
    local dim_offset = UDim2.fromOffset

    local color = Color3.new
    local rgb = Color3.fromRGB
    local hex = Color3.fromHex
    local rgbseq = ColorSequence.new
    local rgbkey = ColorSequenceKeypoint.new

    local camera = ws.CurrentCamera
    local lp = players.LocalPlayer 
    local mouse = lp:GetMouse() 

    local max = math.max 
    local floor = math.floor 
    local min = math.min 
    local abs = math.abs 
    local clamp = math.clamp 

    local insert = table.insert 
    local find = table.find 
    local remove = table.remove
    local concat = table.concat

    local themes = {
        preset = {
            accent = rgb(0, 162, 255),
        }, 

        utility = {
            accent = {
                BackgroundColor3 = {}, 	
                TextColor3 = {}, 
                ImageColor3 = {}, 
                ScrollBarImageColor3 = {} 
            },
        }
    }

    library.__index = library

    local flags = library.flags 
    local config_flags = library.config_flags

    local fonts = {}; do
        function Register_Font(Name, Weight, Style, Asset)
            if not isfile(Asset.Id) then
                writefile(Asset.Id, Asset.Font)
            end

            if isfile(Name .. ".font") then
                delfile(Name .. ".font")
            end

            local Data = {
                name = Name,
                faces = {
                    {
                        name = "Normal",
                        weight = Weight,
                        style = Style,
                        assetId = getcustomasset(Asset.Id),
                    },
                },
            }

            writefile(Name .. ".font", http_service:JSONEncode(Data))

            return getcustomasset(Name .. ".font");
        end
        
        local Medium = Register_Font("Medium", 200, "Normal", {
            Id = "Medium.ttf",
            Font = game:HttpGet("https://github.com/i77lhm/storage/raw/refs/heads/main/fonts/Inter_28pt-Medium.ttf"),
        })

        local SemiBold = Register_Font("SemiBold", 200, "Normal", {
            Id = "SemiBold.ttf",
            Font = game:HttpGet("https://github.com/i77lhm/storage/raw/refs/heads/main/fonts/Inter_28pt-SemiBold.ttf"),
        })

        fonts = {
            small = Font.new(Medium, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
            font = Font.new(SemiBold, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
        }
    end

    function library:tween(obj, properties, easing_style, time) 
        local tween = tween_service:Create(obj, TweenInfo.new(time or 0.25, easing_style or Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, 0, false, 0), properties):Play()
        return tween
    end

    function library:resizify(frame) 
        local Frame = Instance.new("TextButton")
        Frame.Position = dim2(1, -10, 1, -10)
        Frame.BorderColor3 = rgb(0, 0, 0)
        Frame.Size = dim2(0, 10, 0, 10)
        Frame.BorderSizePixel = 0
        Frame.BackgroundColor3 = rgb(255, 255, 255)
        Frame.Parent = frame
        Frame.BackgroundTransparency = 1 
        Frame.Text = ""

        local resizing = false 
        local start_size 
        local start 
        local og_size = frame.Size  

        Frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                resizing = true
                start = input.Position
                start_size = frame.Size
            end
        end)

        Frame.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                resizing = false
            end
        end)

        library:connection(uis.InputChanged, function(input, game_event) 
            if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
                local viewport_x = camera.ViewportSize.X
                local viewport_y = camera.ViewportSize.Y

                local current_size = dim2(
                    start_size.X.Scale,
                    math.clamp(
                        start_size.X.Offset + (input.Position.X - start.X),
                        og_size.X.Offset,
                        viewport_x
                    ),
                    start_size.Y.Scale,
                    math.clamp(
                        start_size.Y.Offset + (input.Position.Y - start.Y),
                        og_size.Y.Offset,
                        viewport_y
                    )
                )

                library:tween(frame, {Size = current_size}, Enum.EasingStyle.Linear, 0.05)
            end
        end)
    end 

    function fag(tbl)
        local Size = 0
        for _ in tbl do
            Size = Size + 1
        end
        return Size
    end
    
    function library:next_flag()
        local index = fag(library.flags) + 1;
        local str = string.format("flagnumber%s", index)
        return str;
    end 

    function library:draggify(frame)
        local dragging = false 
        local start_size = frame.Position
        local start 

        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                start = input.Position
                start_size = frame.Position
            end
        end)

        frame.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        library:connection(uis.InputChanged, function(input, game_event) 
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local viewport_x = camera.ViewportSize.X
                local viewport_y = camera.ViewportSize.Y

                local current_position = dim2(
                    0,
                    clamp(
                        start_size.X.Offset + (input.Position.X - start.X),
                        0,
                        viewport_x - frame.Size.X.Offset
                    ),
                    0,
                    math.clamp(
                        start_size.Y.Offset + (input.Position.Y - start.Y),
                        0,
                        viewport_y - frame.Size.Y.Offset
                    )
                )

                library:tween(frame, {Position = current_position}, Enum.EasingStyle.Linear, 0.05)
                library:close_element()
            end
        end)
    end 

    function library:round(number, float) 
        local multiplier = 1 / (float or 1)
        return floor(number * multiplier + 0.5) / multiplier
    end 

    function library:apply_theme(instance, theme, property) 
        insert(themes.utility[theme][property], instance)
    end

    function library:close_element(new_path) 
        local open_element = library.current_open

        if open_element and new_path ~= open_element then
            open_element.set_visible(false)
            open_element.open = false;
        end 

        if new_path ~= open_element then 
            library.current_open = new_path or nil;
        end
    end 

    function library:create(instance, options)
        local ins = Instance.new(instance) 
        for prop, value in options do 
            ins[prop] = value
        end
        return ins 
    end

    function library:connection(signal, callback)
        local connection = signal:Connect(callback)
        insert(library.connections, connection)
        return connection 
    end

    function library:window(properties)
        local cfg = { 
            suffix = properties.suffix or properties.Suffix or "hub";
            name = properties.name or properties.Name or "Corpse";
            game_name = properties.gameInfo or properties.game_info or properties.GameInfo;
            size = properties.size or properties.Size or dim2(0, 700, 0, 565);
            selected_tab;
            items = {};
        }
        
        library[ "items" ] = library:create( "ScreenGui" , {
            Parent = core_gui;
            Name = "\0";
            Enabled = true;
            ZIndexBehavior = Enum.ZIndexBehavior.Global;
            IgnoreGuiInset = true;
        });
        
        library[ "other" ] = library:create( "ScreenGui" , {
            Parent = core_gui;
            Name = "\0";
            Enabled = false;
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
            IgnoreGuiInset = true;
        }); 

        local items = cfg.items; do
            items[ "main" ] = library:create( "Frame" , {
                Parent = library[ "items" ];
                Size = cfg.size;
                Name = "\0";
                Position = dim2(0.5, -cfg.size.X.Offset / 2, 0.5, -cfg.size.Y.Offset / 2);
                BorderColor3 = rgb(0, 0, 0);
                BorderSizePixel = 0;
                BackgroundColor3 = rgb(14, 14, 16),
            }); items[ "main" ].Position = dim2(0, items[ "main" ].AbsolutePosition.X, 0, items[ "main" ].AbsolutePosition.Y)
            
            library:create( "UICorner" , {
                Parent = items[ "main" ];
                CornerRadius = dim(0, 10)
            });
            
            library:create( "UIStroke" , {
                Color = rgb(23, 23, 29);
                Parent = items[ "main" ];
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            });
            
            items[ "side_frame" ] = library:create( "Frame" , {
                Parent = items[ "main" ];
                BackgroundTransparency = 1;
                Name = "\0";
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(0, 196, 1, -25);
                BorderSizePixel = 0;
                BackgroundColor3 = rgb(14, 14, 16)
            });
            
            library:create( "Frame" , {
                AnchorPoint = vec2(1, 0);
                Parent = items[ "side_frame" ];
                Position = dim2(1, 0, 0, 0);
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(0, 1, 1, 0);
                BorderSizePixel = 0;
                BackgroundColor3 = rgb(21, 21, 23)
            });
            
            items[ "button_holder" ] = library:create( "Frame" , {
                Parent = items[ "side_frame" ];
                Name = "\0";
                BackgroundTransparency = 1;
                Position = dim2(0, 0, 0, 60);
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(1, 0, 1, -60);
                BorderSizePixel = 0;
                BackgroundColor3 = rgb(255, 255, 255)
            }); cfg.button_holder = items[ "button_holder" ];
            
            library:create( "UIListLayout" , {
                Parent = items[ "button_holder" ];
                Padding = dim(0, 5);
                SortOrder = Enum.SortOrder.LayoutOrder
            });
            
            library:create( "UIPadding" , {
                PaddingTop = dim(0, 16);
                PaddingBottom = dim(0, 36);
                Parent = items[ "button_holder" ];
                PaddingRight = dim(0, 11);
                PaddingLeft = dim(0, 10)
            });

            items[ "title" ] = library:create( "TextLabel" , {
                FontFace = fonts.font;
                BorderColor3 = rgb(0, 0, 0);
                Text = string.format('<u>%s</u><font color = "rgb(255, 255, 255)">%s</font>', cfg.name, cfg.suffix);
                Parent = items[ "side_frame" ];
                Name = "\0";
                BackgroundTransparency = 1;
                Size = dim2(1, 0, 0, 70);
                TextColor3 = themes.preset.accent;
                BorderSizePixel = 0;
                RichText = true;
                TextSize = 30;
                BackgroundColor3 = rgb(255, 255, 255)
            }); library:apply_theme(items[ "title" ], "accent", "TextColor3");
            
            items[ "multi_holder" ] = library:create( "Frame" , {
                Parent = items[ "main" ];
                Name = "\0";
                BackgroundTransparency = 1;
                Position = dim2(0, 196, 0, 0);
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(1, -196, 0, 56);
                BorderSizePixel = 0;
                BackgroundColor3 = rgb(255, 255, 255)
            }); cfg.multi_holder = items[ "multi_holder" ];
            
            library:create( "Frame" , {
                AnchorPoint = vec2(0, 1);
                Parent = items[ "multi_holder" ];
                Position = dim2(0, 0, 1, 0);
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(1, 0, 0, 1);
                BorderSizePixel = 0;
                BackgroundColor3 = rgb(21, 21, 23)
            });
            
            items[ "shadow" ] = library:create( "ImageLabel" , {
                ImageColor3 = rgb(0, 0, 0);
                ScaleType = Enum.ScaleType.Slice;
                Parent = items[ "main" ];
                BorderColor3 = rgb(0, 0, 0);
                Name = "\0";
                BackgroundColor3 = rgb(255, 255, 255);
                Size = dim2(1, 75, 1, 75);
                AnchorPoint = vec2(0.5, 0.5);
                Image = "rbxassetid://112971167999062";
                BackgroundTransparency = 1;
                Position = dim2(0.5, 0, 0.5, 0);
                SliceScale = 0.75;
                ZIndex = -100;
                BorderSizePixel = 0;
                SliceCenter = rect(vec2(112, 112), vec2(147, 147))
            });
            
            items[ "global_fade" ] = library:create( "Frame" , {
                Parent = items[ "main" ];
                Name = "\0";
                BackgroundTransparency = 1;
                Position = dim2(0, 196, 0, 56);
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(1, -196, 1, -81);
                BorderSizePixel = 0;
                BackgroundColor3 = rgb(14, 14, 16);
                ZIndex = 2;
            });                

            library:create( "UICorner" , {
                Parent = items[ "shadow" ];
                CornerRadius = dim(0, 5)
            });
            
            items[ "info" ] = library:create( "Frame" , {
                AnchorPoint = vec2(0, 1);
                Parent = items[ "main" ];
                Name = "\0";
                Position = dim2(0, 0, 1, 0);
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(1, 0, 0, 25);
                BorderSizePixel = 0;
                BackgroundColor3 = rgb(23, 23, 25)
            });
            
            library:create( "UICorner" , {
                Parent = items[ "info" ];
                CornerRadius = dim(0, 10)
            });
            
            items[ "game" ] = library:create( "TextLabel" , {
                FontFace = fonts.font;
                Parent = items[ "info" ];
                TextColor3 = rgb(72, 72, 73);
                BorderColor3 = rgb(0, 0, 0);
                Text = cfg.game_name;
                Name = "\0";
                Size = dim2(1, 0, 0, 0);
                AnchorPoint = vec2(0, 0.5);
                Position = dim2(0, 10, 0.5, -1);
                BackgroundTransparency = 1;
                TextXAlignment = Enum.TextXAlignment.Left;
                BorderSizePixel = 0;
                AutomaticSize = Enum.AutomaticSize.XY;
                TextSize = 14;
                BackgroundColor3 = rgb(255, 255, 255)
            }); 
        end 

        do 
            library:draggify(items[ "main" ])
            library:resizify(items[ "main" ])
        end 
            
        return setmetatable(cfg, library)
    end 
end

-- INITIALIZE WINDOW WITH "Corpse" AS THE TITLE
if not Mobile then
    local Window = library:window({
        Name = "Corpse",
        Suffix = "Hub",
        GameInfo = "Rivals"
    })
end
