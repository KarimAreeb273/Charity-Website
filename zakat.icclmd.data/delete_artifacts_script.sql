select  dbo.ARTIFACT.artifactId 
from    dbo.ARTIFACT 
where   dbo.ARTIFACT.applicationId in 
        (
	        select applicationId 
          from dbo.APPLICATION 
          where dbo.APPLICATION.applicationStatus in 
          (
            'Rejected', 
            'Dispersed'
          )
        )

delete  from dbo.ARTIFACT 
where   dbo.ARTIFACT.applicationId in
        (
          select applicationId 
          from dbo.APPLICATION 
          where dbo.APPLICATION.applicationStatus in 
          (
            'Rejected', 
            'Dispersed'
          )
        )
