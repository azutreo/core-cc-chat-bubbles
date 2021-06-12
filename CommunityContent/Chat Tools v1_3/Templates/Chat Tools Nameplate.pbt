Assets {
  Id: 365120532387301526
  Name: "Chat Tools Nameplate"
  PlatformAssetType: 5
  TemplateAsset {
    ObjectBlock {
      RootId: 13287460181255766552
      Objects {
        Id: 13287460181255766552
        Name: "Chat Tools Nameplate"
        Transform {
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 4781671109827199097
        ChildIds: 7017793607915543750
        ChildIds: 2700192188813288565
        Collidable_v2 {
          Value: "mc:ecollisionsetting:forceoff"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:forceoff"
        }
        Folder {
          IsGroup: true
        }
      }
      Objects {
        Id: 7017793607915543750
        Name: "Text"
        Transform {
          Location {
            X: 0.100006104
          }
          Rotation {
          }
          Scale {
            X: 0.8
            Y: 0.8
            Z: 0.8
          }
        }
        ParentId: 13287460181255766552
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Text {
          Text: "Message Text |"
          FontAsset {
            Id: 5428334077924050149
          }
          Color {
            R: 1
            G: 1
            B: 1
            A: 1
          }
          HorizontalSize: 1
          VerticalSize: 1
          HorizontalAlignment {
            Value: "mc:ecoretexthorizontalalign:center"
          }
          VerticalAlignment {
            Value: "mc:ecoretextverticalalign:center"
          }
        }
      }
      Objects {
        Id: 2700192188813288565
        Name: "Background"
        Transform {
          Location {
          }
          Rotation {
          }
          Scale {
            X: 0.001
            Y: 1.5
            Z: 0.225
          }
        }
        ParentId: 13287460181255766552
        UnregisteredParameters {
          Overrides {
            Name: "ma:Shared_BaseMaterial:id"
            AssetReference {
              Id: 18301446516921762460
            }
          }
          Overrides {
            Name: "ma:Shared_BaseMaterial:color"
            Color {
              A: 0.2
            }
          }
        }
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:forceoff"
        }
        CoreMesh {
          MeshAsset {
            Id: 12095835209017042614
          }
          Teams {
            IsTeamCollisionEnabled: true
            IsEnemyCollisionEnabled: true
          }
          StaticMesh {
            Physics {
              Mass: 100
              LinearDamping: 0.01
            }
            BoundsScale: 1
          }
        }
      }
    }
    Assets {
      Id: 5428334077924050149
      Name: "Cabin Bold"
      PlatformAssetType: 28
      PrimaryAsset {
        AssetType: "FontAssetRef"
        AssetId: "CabinBold_ref"
      }
    }
    Assets {
      Id: 12095835209017042614
      Name: "Cube"
      PlatformAssetType: 1
      PrimaryAsset {
        AssetType: "StaticMeshAssetRef"
        AssetId: "sm_cube_002"
      }
    }
    Assets {
      Id: 18301446516921762460
      Name: "Invisible"
      PlatformAssetType: 2
      PrimaryAsset {
        AssetType: "MaterialAssetRef"
        AssetId: "mi_invisible_001"
      }
    }
    PrimaryAssetId {
      AssetType: "None"
      AssetId: "None"
    }
  }
  Marketplace {
    Description: "NOTE 1: This template will require some setup, more info in the README and config scripts.\r\nNOTE 2: Backup your config before installing an update, as it may be overwritten during the process.\r\n\r\nChat Tools is a set of scripts and templates that adds a commands and permissions system, nameplates and chat bubbles to the game.\r\nEvery feature is configurable and can be even disabled if you\'re, for example, looking only for commands.\r\nYou can write and register your own commands using this framework without much hassle.\r\n\r\nCan be used by both newcomers and experienced users - more detailed customization requires some experience with lua, but if all you need is some simple commands or ui components to enrich player experience or for moderation purposes then you won\'t even need to know what you\'re really doing.\r\n\r\nCurrently included out-of-the-box commands:\r\n- help\r\n- kick\r\n- ban\r\n- kill\r\n- fly\r\n- tp\r\n- nick\r\n- unnick\r\n- respawn\r\n- ragdoll\r\n- fling"
  }
  SerializationVersion: 87
  DirectlyPublished: true
}
